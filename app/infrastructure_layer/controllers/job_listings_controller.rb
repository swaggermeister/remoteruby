# frozen_string_literal: true

# rubocop:disable Metrics/ClassLength
class JobListingsController < ApplicationController
  skip_before_action :authenticate_employer!, only: %i[index show]

  def index
    result = ::JobListings::IndexUseCase.call(
      job_listings_repository: JobListingsRepository,
      employers_repository: EmployersRepository,
      query: params[:search],
      employer_id: params[:employer_id],
      sort_column: params[:sort_column],
      page_num: params[:page] || 1,
    )

    prepare_view!(::JobListings::IndexViewModel,
                  search_text: result.query,
                  filtering_by_employer: result.filtering_by_employer,
                  paginator: result.paginator,
                  job_listings: result.job_listings,
                  sort_column: result.sort_column,
                  request: request)
  end

  def show
    result = JobListings::ShowUseCase.call(
      job_listings_repository: JobListingsRepository,
      id: params.fetch(:id),
      search_text: params[:search_text],
    )

    prepare_view!(JobListings::ShowViewModel,
                  job_listing: result.job_listing,
                  employer_num_job_listings: result.employer_num_job_listings,
                  search_text: result.search_text)

    # HTTP caching with etag
    # https://guides.rubyonrails.org/caching_with_rails.html#conditional-get-support
    fresh_when result.job_listing
  end

  def new
    result = JobListings::NewUseCase.call

    prepare_view!(JobListings::NewViewModel,
                  job_listing: result.job_listing)
  end

  def edit
    result = JobListings::EditUseCase.call(
      job_listings_repository: JobListingsRepository,
      id: params.fetch(:id),
    )

    prepare_view!(JobListings::EditViewModel,
                  job_listing: result.job_listing)
  end

  def create
    result = JobListings::CreateUseCase.call(
      job_listings_repository: JobListingsRepository,
      attrs: job_listing_params,
      employer_id: current_employer.id,
    )

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully created."
    else
      prepare_view!(JobListings::NewViewModel,
                    job_listing: result.job_listing)
    end
  end

  def update
    result = JobListings::UpdateUseCase.call(
      job_listings_repository: JobListingsRepository,
      id: params.fetch(:id), attrs: job_listing_params,
    )

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully updated."
    else
      prepare_view!(JobListings::EditViewModel,
                    job_listing: result.job_listing)
    end
  end

  def destroy
    result = JobListings::DestroyUseCase.call(
      job_listings_repository: JobListingsRepository,
      id: params.fetch(:id),
    )

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully destroyed."
    else
      @job_listing
    end
  end

  def my_company
    result = JobListings::MyCompanyUseCase.call(
      job_listings_repository: JobListingsRepository,
      employer_id: current_employer.id,
    )

    prepare_view!(JobListings::MyCompanyViewModel,
                  job_listings: result.job_listings)
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

# rubocop:enable Metrics/ClassLength
