# frozen_string_literal: true

module JobListings
  module IndexUseCase
    PAGINATION_COUNT = 10
    DEFAULT_SORT_COLUMN = "created_at"

    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)
    Result = Struct.new(:paginator, :job_listings, :query, :filtering_by_employer, :sort_column, keyword_init: true)

    class << self
      include ::Pagy::Backend

      def call(query:, employer_id:, page_num:, sort_column:)
        query ||= ""
        query = query.strip
        sort_column ||= DEFAULT_SORT_COLUMN

        pagination = find_paginated_job_listings(
          query: query,
          employer_id: employer_id,
          page_num: page_num,
          sort_column: sort_column,
        )
        employer = find_employer(employer_id)

        Result.new(
          paginator: pagination.paginator,
          job_listings: pagination.job_listings,
          query: query,
          sort_column: sort_column,
          filtering_by_employer: employer,
        )
      end

      private

      def find_employer(employer_id)
        return nil if employer_id.blank?

        Employer.find(employer_id)
      end

      VALID_SORT_COLUMNS = %w[minimum_salary maximum_salary fixed_amount created_at].freeze

      def find_paginated_job_listings(query:, employer_id:, page_num:, sort_column:)
        raise "Invalid sort column #{sort_column}" unless VALID_SORT_COLUMNS.include?(sort_column)

        # base scope
        scope = JobListing.includes({ employer: :avatar_attachment }).order("#{sort_column} DESC NULLS LAST")

        # filter by employer
        scope = scope.where(employer_id: employer_id) if employer_id.present?

        # filter by query
        scope = if query.present?
            scope.search(query)
            # query = query.where(["title ilike :search or description ilike :search", search: "%#{query}%"])
          else
            scope
          end

        paginator, job_listings = pagy(scope, items: PAGINATION_COUNT, page: page_num)

        Pagination.new(paginator: paginator, job_listings: job_listings)
      end
    end
  end
end
