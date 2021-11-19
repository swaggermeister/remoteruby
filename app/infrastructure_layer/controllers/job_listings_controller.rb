# frozen_string_literal: true

class JobListingsController < ApplicationController
  skip_before_action :authenticate_employer!, only: %i[index show]

  def index
    result = ::JobListings::IndexQuery.call(
      job_listings_query_repository: JobListingsQueryRepository,
      employers_query_repository: EmployersQueryRepository,
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
    result = JobListings::ShowQuery.call(
      job_listings_query_repository: JobListingsQueryRepository,
      id: params.fetch(:id),
      search_text: params[:search_text],
    )

    prepare_view!(JobListings::ShowViewModel,
                  job_listing: result.job_listing,
                  employer_num_job_listings: result.employer_num_job_listings,
                  search_text: result.search_text)
  end

  def new
    result = JobListings::NewQuery.call

    prepare_view!(JobListings::NewViewModel,
                  job_listing: result.job_listing)
  end

  def edit
    result = JobListings::EditQuery.call(
      job_listings_query_repository: JobListingsQueryRepository,
      id: params.fetch(:id),
    )

    prepare_view!(JobListings::EditViewModel,
                  job_listing: result.job_listing)
  end

  def create
    result = JobListings::CreateCommand.call(
      job_listings_command_repository: JobListingsCommandRepository,
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
    result = JobListings::UpdateCommand.call(
      job_listings_query_repository: JobListingsQueryRepository,
      job_listings_command_repository: JobListingsCommandRepository,
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
    result = JobListings::DestroyCommand.call(
      job_listings_command_repository: JobListingsCommandRepository,
      id: params.fetch(:id),
    )

    if result.success
      redirect_to my_company_job_listings_path, notice: "Job listing was successfully destroyed."
    else
      @job_listing
    end
  end

  def my_company
    result = JobListings::MyCompanyQuery.call(
      job_listings_query_repository: JobListingsQueryRepository,
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
