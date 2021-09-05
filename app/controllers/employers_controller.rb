# frozen_string_literal: true

class EmployersController < ApplicationController
  before_action :authenticate_employer!

  def show
    result = Employers::ShowUseCase.call(id: params.fetch(:id))

    @employer = result.employer
  end

  def edit
    result = Employers::EditUseCase.call(id: params.fetch(:id))

    @employer = result.employer
  end

  def update
    result = Employers::UpdateUseCase.call(id: params.fetch(:id), attrs: employer_params)

    if result.success
      # todo: update bypass to bypass_sign_in
      sign_in :employer, result.employer, bypass: true

      redirect_to edit_employer_path(result.employer), notice: "Account successfully updated."
    else
      render :edit
    end
  end

  def destroy
    result = Employers::DestroyUseCase.call(id: params.fetch(:id))

    if result.success
      redirect_to job_listings_url, notice: "Account was successfully deleted."
    else
      current_employer
    end
  end

  private

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :email, :password, :encrypted_password, :password_confirmation)
  end
end
