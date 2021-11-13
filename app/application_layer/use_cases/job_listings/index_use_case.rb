# frozen_string_literal: true

module JobListings
  module IndexUseCase
    Result = Struct.new(:paginator, :job_listings, :query, :filtering_by_employer, :last_updated_job_listing, :sort_column, keyword_init: true)

    DEFAULT_SORT_COLUMN = "created_at"
    PAGINATION_COUNT = 10

    class << self
      def call(job_listings_repository:, employers_repository:, query:, employer_id:, page_num:, sort_column:)
        query ||= ""
        query = query.strip
        sort_column ||= DEFAULT_SORT_COLUMN

        pagination = get_pagination(
          job_listings_repository: job_listings_repository,
          query: query,
          employer_id: employer_id,
          page_num: page_num,
          sort_column: sort_column,
        )
        last_updated_job_listing = get_last_updated_job_listing(job_listings_repository: job_listings_repository)
        filtering_by_employer = employers_repository.find(id: employer_id)

        Result.new(
          paginator: pagination.paginator,
          job_listings: result_job_listings(pagination: pagination),
          last_updated_job_listing: last_updated_job_listing,
          query: query,
          sort_column: sort_column,
          filtering_by_employer: filtering_by_employer,
        )
      end

      private

      def result_job_listings(pagination:)
        pagination.job_listings.map do |job_listing|
          ResultEntities::ResultJobListing.from_entity(job_listing)
        end
      end

      def get_pagination(job_listings_repository:, query:, employer_id:, page_num:, sort_column:)
        job_listings_repository.list(
          query: query,
          employer_id: employer_id,
          page_num: page_num,
          sort_column: sort_column,
          pagination_count: PAGINATION_COUNT,
        )
      end

      def get_last_updated_job_listing(job_listings_repository:)
        job_listings_repository.last_updated
      end
    end
  end
end
