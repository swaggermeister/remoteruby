class EmployersController < ApplicationController
  skip_before_action :authorize, only: %i[new create]
  before_action :set_employer, only: %i[show edit update destroy]

  def index
    @employers = Employer.all
  end

  def show
  end

  def new
    @employer = Employer.new
  end

  def edit
  end

  def create
    @employer = Employer.new(employer_params)

    if @employer.save
      session[:employer_id] = @employer.id
      redirect_to @employer, notice: "Account successfully created."
    else
      render :new
    end
  end

  def update
    if @employer.update(employer_params)
      redirect_to @employer, notice: "Account successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @employer.destroy
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
