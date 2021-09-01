class JobListingsController < ApplicationController
  skip_before_action :authenticate_employer!, only: [:index, :show]
  before_action :set_job_listing, only: [:show, :edit, :update, :destroy]

  def index
    query = JobListing
    if (@search_text = params[:search])
      query = JobListing.search(@search_text)
      # query = query.where(["title ilike :search or description ilike :search", search: "%#{@search_text}%"])
    end

    @job_listings = query.all
  end

  def show
  end

  def new
    @job_listing = JobListing.new
  end

  def edit
  end

  def create
    employer = current_employer
    @job_listing = JobListing.new(job_listing_params.merge(employer_id: employer.id))

    if @job_listing.save
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully created."
    else
      render :new
    end
  end

  def update
    if @job_listing.update(job_listing_params)
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @job_listing.destroy
    redirect_to my_company_job_listings_path, notice: "Job listing was successfully destroyed."
  end

  # just get a random #/selection of listings to display for now
  # def search
  #   search_text = params[:search]
  #   # random = Random.new
  #   # number_of_listings = random.rand(0..5)
  #   @job_listings = JobListing.where(["title like ? or description like ?", search_text]).all # .limit(number_of_listings).order("RANDOM()").all
  # end

  def my_company
    @job_listings = current_employer.job_listings
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
