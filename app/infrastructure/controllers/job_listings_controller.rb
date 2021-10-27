# frozen_string_literal: true

class JobListingsController < ApplicationController
  skip_before_action :authenticate_employer!, only: %i[index show]

  def index
    result = ::JobListings::IndexUseCase.call(query: params[:search], employer_id: params[:employer_id], sort_column: params[:sort_column], page_num: params[:page] || 1)

    @view = ::JobListings::IndexView.new(
      search_text: result.query,
      filtering_by_employer: result.filtering_by_employer,
      paginator: result.paginator,
      job_listings: result.job_listings,
      sort_column: result.sort_column,
      request: request,
    )

    # Etag caching has to take into account:
    # Params (sort order, search text query, employer filtering) + Last updated job listing
    # latest_job_listing = JobListing.order(:updated_at).last
    # fresh_when last_modified: latest_job_listing.updated_at.utc, etag: Digest::MD5.hexdigest(Marshal.dump(params))
  end

  def show
    result = JobListings::ShowUseCase.call(id: params.fetch(:id), search_text: params[:search_text])

    @view = JobListings::ShowView.new(
      job_listing: result.job_listing,
      search_text: result.search_text,
    )

    # HTTP caching with etag
    # https://guides.rubyonrails.org/caching_with_rails.html#conditional-get-support
    fresh_when result.job_listing
  end

  def new
    result = JobListings::NewUseCase.call

    @view = JobListings::NewView.new(
      job_listing: result.job_listing,
    )
  end

  def edit
    result = JobListings::EditUseCase.call(id: params.fetch(:id))

    @view = JobListings::EditView.new(
      job_listing: result.job_listing,
    )
  end

  def create
    result = JobListings::CreateUseCase.call(attrs: job_listing_params, employer_id: current_employer.id)

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully created."
    else
      @view = JobListings::NewView.new(
        job_listing: result.job_listing,
      )
    end
  end

  def update
    result = JobListings::UpdateUseCase.call(id: params.fetch(:id), attrs: job_listing_params)

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully updated."
    else
      @view = JobListings::EditView.new(
        job_listing: result.job_listing,
      )
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

    @view = JobListings::MyCompanyView.new(
      job_listings: result.job_listings,
    )

    # Etag caching has to take into account:
    # Params (sort order, search text query, employer filtering) + Last updated job listing
    latest_job_listing = current_employer.job_listings.order(:updated_at).last
    fresh_when last_modified: latest_job_listing.updated_at.utc, etag: Digest::MD5.hexdigest(Marshal.dump(params))
  end

  private

  # Only allow a list of trusted parameters through.
  def job_listing_params
    params.require(:job_listing).permit(
      :title,
      :description,
      :location,
      :minimum_salary,
      :maximum_salary,
      :fixed_amount,
      :salary,
      :contact_email,
      :contact_url
    )
  end
end
