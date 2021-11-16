# frozen_string_literal: true

class EmployersController < ApplicationController
  before_action :authenticate_employer!

  def show
    result = Employers::ShowUseCase.call(
      employers_repository: EmployersRepository,
      id: params.fetch(:id),
    )

    prepare_view!(Employers::ShowViewModel,
                  employer: result.employer)
  end

  def edit
    result = Employers::EditUseCase.call(
      employers_repository: EmployersRepository,
      id: params.fetch(:id),
    )

    prepare_view!(Employers::EditViewModel,
                  employer: result.employer)
  end

  def update
    result = Employers::UpdateUseCase.call(
      employers_repository: EmployersRepository,
      id: params.fetch(:id),
      attrs: employer_params,
    )

    if result.success
      # HACK: we need to get the ActiveRecord object manually here
      # since devise is so tightly coupled to AR
      employer_record = EmployerRecord.find(result.employer.id)

      # keep employer signed in after successfully updating profile/changing password
      bypass_sign_in employer_record, scope: :employer

      redirect_to edit_employer_path(result.employer), notice: "Account successfully updated."
    else
      prepare_view!(Employers::EditViewModel,
                    employer: result.employer)
    end
  end

  def destroy
    result = Employers::DestroyUseCase.call(
      employers_repository: EmployersRepository,
      id: params.fetch(:id),
    )

    raise "Could not destroy the employer" unless result.success

    redirect_to job_listings_url, notice: "Account was successfully deleted."
  end

  private

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :avatar, :email, :password, :encrypted_password, :password_confirmation)
  end
end
