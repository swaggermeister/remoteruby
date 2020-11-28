class JobListingsController < ApplicationController
  skip_before_action :authorize, only: [:index, :show]
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy]

  # GET /job_listings
  # GET /job_listings.json
  def index
    query = JobListing
    if (@search_text = params[:search])
      query = query.where(["title ilike :search or description ilike :search", search: "%#{@search_text}%"])
    end

    @job_listings = query.all
  end

  # GET /job_listings/1
  # GET /job_listings/1.json
  def show
  end

  # GET /job_listings/new
  def new
    @job_listing = JobListing.new
  end

  # GET /job_listings/1/edit
  def edit
  end

  # POST /job_listings
  # POST /job_listings.json
  def create
    employer = Employer.first
    @job_listing = JobListing.new(job_listing_params.merge(employer_id: employer.id))

    if @job_listing.save
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully created."
    else
      render :new
    end
  end

  # PATCH/PUT /job_listings/1
  # PATCH/PUT /job_listings/1.json
  def update
    if @job_listing.update(job_listing_params)
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /job_listings/1
  # DELETE /job_listings/1.json
  def destroy
    @job_listing.destroy
    redirect_to my_company_job_listings_path, notice: "Job listing was successfully destroyed."
  end

  # GET /job_listings/search
  # just get a random #/selection of listings to display for now
  # def search
  #   search_text = params[:search]
  #   # random = Random.new
  #   # number_of_listings = random.rand(0..5)
  #   @job_listings = JobListing.where(["title like ? or description like ?", search_text]).all # .limit(number_of_listings).order("RANDOM()").all
  # end

  def my_company
    # random = Random.new
    # number_of_listings = random.rand(0..5)
    # @employer = Employer.limit(1).order("RANDOM()").first
    # @job_listings = JobListing.limit(number_of_listings).order("RANDOM()").all
    @employer = current_user
    @job_listings = @employer.job_listings
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job_listing
    @job_listing = JobListing.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :location, :salary, :contact_email, :contact_url)
  end
end
