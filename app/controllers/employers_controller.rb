class EmployersController < ApplicationController
  before_action :authenticate_employer!
  # skip_before_action :authorize, only: %i[new create]
  before_action :set_employer, only: %i[show edit update destroy]

  def index
    @employers = Employer.all
  end

  def show
  end

  def edit
  end

  def update
    if current_employer.update(employer_params)
      redirect_to current_employer, notice: "Account successfully updated."
    else
      render :edit
    end
  end

  def destroy
    current_employer.destroy
    redirect_to job_listings_url, notice: "Account was successfully deleted."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employer
    @employer = Employer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(:name, :email, :password, :password_confirmation)
  end
end
