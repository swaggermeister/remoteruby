# frozen_string_literal: true

class JobListingsController < ApplicationController
  skip_before_action :authenticate_employer!, only: %i[index show]

  def index
    result = ::JobListings::IndexUseCase.call(query: params[:search], page_num: params[:page] || 1)

    @presenter = ::JobListings::IndexPresenter.new(
      search_text: result.query,
      paginator: result.paginator,
      job_listings: result.job_listings,
    )
  end

  def show
    result = JobListings::ShowUseCase.call(id: params.fetch(:id))

    @presenter = JobListings::ShowPresenter.new(
      job_listing: result.job_listing,
    )
  end

  def new
    result = JobListings::NewUseCase.call

    @presenter = JobListings::NewPresenter.new(
      job_listing: result.job_listing,
    )
  end

  def edit
    result = JobListings::EditUseCase.call(id: params.fetch(:id))

    @presenter = JobListings::EditPresenter.new(
      job_listing: result.job_listing,
    )
  end

  def create
    result = JobListings::CreateUseCase.call(attrs: job_listing_params, employer_id: current_employer.id)

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully created."
    else
      @job_listing = result.job_listing
      render :new
    end
  end

  def update
    result = JobListings::UpdateUseCase.call(id: params.fetch(:id), attrs: job_listing_params)

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    result = JobListings::DestroyUseCase.call(id: params.fetch(:id))

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully destroyed."
    else
      @job_listing
    end
  end

  def my_company
    result = JobListings::MyCompanyUseCase.call(employer: current_employer)

    @presenter = JobListings::MyCompanyPresenter.new(
      job_listings: result.job_listings,
    )
  end

  private

  # Only allow a list of trusted parameters through.
  def job_listing_params
    params.require(:job_listing).permit(:title, :description, :location, :salary, :contact_email, :contact_url)
  end
end
