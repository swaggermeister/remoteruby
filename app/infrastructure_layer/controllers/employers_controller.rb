# frozen_string_literal: true

class EmployersController < ApplicationController
  before_action :authenticate_employer!

  def show
    result = Employers::ShowUseCase.call(id: params.fetch(:id))

    @view = Employers::ShowViewModel.new(
      employer: result.employer,
    )
  end

  def edit
    result = Employers::EditUseCase.call(id: params.fetch(:id))

    @view = Employers::EditViewModel.new(
      employer: result.employer,
    )
  end

  def update
    result = Employers::UpdateUseCase.call(id: params.fetch(:id), attrs: employer_params)

    if result.success
      # keep employer signed in after successfully updating profile/changing password
      bypass_sign_in result.employer

      redirect_to edit_employer_path(result.employer), notice: "Account successfully updated."
    else
      @view = Employers::EditViewModel.new(
        employer: result.employer,
      )
    end
  end

  def destroy
    result = Employers::DestroyUseCase.call(id: params.fetch(:id))

    raise "Could not destroy the employer" unless result.success

    redirect_to job_listings_url, notice: "Account was successfully deleted."
  end

  private

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :avatar, :email, :password, :encrypted_password, :password_confirmation)
  end
end