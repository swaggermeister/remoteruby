class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)

    if @employer.save
      redirect_to @employer, notice: "Account successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    if @employer.update(employer_params)
      redirect_to @employer, notice: "Account successfully updated."
    else
      render :edit
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.json
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
    params.require(:employer).permit(:name, :email, :password)
  end
end
