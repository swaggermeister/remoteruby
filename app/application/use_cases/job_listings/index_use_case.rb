# frozen_string_literal: true

module JobListings
  module IndexUseCase
    PAGINATION_COUNT = 10

    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)
    Result = Struct.new(:paginator, :job_listings, :query, :sort_column, keyword_init: true)

    class << self
      include ::Pagy::Backend

      def call(query:, page_num:, sort_column:)
        query ||= ""
        query = query.strip
        sort_column ||= "created_at"

        pagination = find_paginated_job_listings(query: query, page_num: page_num, sort_column: sort_column)

        Result.new(paginator: pagination.paginator, job_listings: pagination.job_listings, query: query, sort_column: sort_column)
      end

      private

      def find_paginated_job_listings(query:, page_num:, sort_column:)
        scope = JobListing

        scope = if query.present?
            scope.search(query)
            # query = query.where(["title ilike :search or description ilike :search", search: "%#{query}%"])
          else
            scope
          end

        paginator, job_listings = pagy(scope, items: PAGINATION_COUNT, page: page_num)
        job_listings = order_job_listings(job_listings: job_listings, sort_column: sort_column)

        Pagination.new(paginator: paginator, job_listings: job_listings)
      end

      VALID_SORT_COLUMNS = %w[salary created_at].freeze

      def order_job_listings(job_listings:, sort_column:)
        raise "Invalid sort column #{sort_column}" unless VALID_SORT_COLUMNS.include?(sort_column)

        job_listings.order({ sort_column => :desc })
      end
    end
  end
end
