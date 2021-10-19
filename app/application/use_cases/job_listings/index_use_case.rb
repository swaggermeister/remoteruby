# frozen_string_literal: true

module JobListings
  module IndexUseCase
    PAGINATION_COUNT = 10

    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)
    Result = Struct.new(:paginator, :job_listings, :query, :employer_id, :sort_column, keyword_init: true)

    class << self
      include ::Pagy::Backend

      def call(query:, employer_id:, page_num:, sort_column:)
        query ||= ""
        query = query.strip
        employer_id ||= 0
        sort_column ||= "created_at"

        pagination = find_paginated_job_listings(query: query, employer_id: employer_id, page_num: page_num, sort_column: sort_column)

        Result.new(paginator: pagination.paginator, job_listings: pagination.job_listings, query: query, employer_id: employer_id, sort_column: sort_column)
      end

      private

      def find_paginated_job_listings(query:, employer_id:, page_num:, sort_column:)
        scope = JobListing

        scope = if query.present?
            scope.search(query)
            # query = query.where(["title ilike :search or description ilike :search", search: "%#{query}%"])
          else
            scope
          end

        scope = find_job_listings(scope: scope, employer_id: employer_id, sort_column: sort_column)
        paginator, job_listings = pagy(scope, items: PAGINATION_COUNT, page: page_num)

        Pagination.new(paginator: paginator, job_listings: job_listings)
      end

      VALID_SORT_COLUMNS = %w[minimum_salary maximum_salary fixed_amount created_at].freeze

      def find_job_listings(scope:, employer_id:, sort_column:)
        raise "Invalid sort column #{sort_column}" unless VALID_SORT_COLUMNS.include?(sort_column)

        job_listings = employer_id.to_i.zero? ? scope : scope.where(employer_id: employer_id)
        job_listings.includes({ employer: :avatar_attachment }).order("#{sort_column} DESC NULLS LAST")
      end
    end
  end
end
