# frozen_string_literal: true

class EmployersController < ApplicationController
  before_action :authenticate_employer!

  def show
    result = Employers::ShowUseCase.call(id: params.fetch(:id))

    @view = Employers::ShowView.new(
      employer: result.employer,
    )
  end

  def edit
    result = Employers::EditUseCase.call(id: params.fetch(:id))

    @view = Employers::EditView.new(
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
      # TODO: handle errors on the form
    end
  end

  def destroy
    result = Employers::DestroyUseCase.call(id: params.fetch(:id))

    if result.success
      redirect_to job_listings_url, notice: "Account was successfully deleted."
    else
      # TODO: handle error, by showing an error toast?
      raise "Could not destroy the employer"
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :avatar, :email, :password, :encrypted_password, :password_confirmation)
  end
end
