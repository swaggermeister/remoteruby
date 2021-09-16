# frozen_string_literal: true

module JobListings
  module IndexUseCase
    PAGINATION_COUNT = 15

    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)
    Result = Struct.new(:paginator, :job_listings, :query, :sortcolumn, keyword_init: true)

    class << self
      include ::Pagy::Backend

      def call(query:, page_num:, sortcolumn:)
        query = query&.strip
        sortcolumn ||= "created_at"

        pagination = find_paginated_job_listings(query: query, page_num: page_num, sortcolumn: sortcolumn)

        Result.new(paginator: pagination.paginator, job_listings: pagination.job_listings, query: query, sortcolumn: sortcolumn)
      end

      private

      def find_paginated_job_listings(query:, page_num:, sortcolumn:)
        scope = JobListing

        scope = if query.present?
            scope.search(query)
            # query = query.where(["title ilike :search or description ilike :search", search: "%#{@search_text}%"])
          else
            scope
          end

        paginator, job_listings = pagy(scope, items: PAGINATION_COUNT, page: page_num)
        job_listings = order_job_listings(job_listings: job_listings, sortcolumn: sortcolumn)

        Pagination.new(paginator: paginator, job_listings: job_listings)
      end

      VALID_SORT_COLUMNS = %w[salary created_at].freeze

      def order_job_listings(job_listings:, sortcolumn:)
        raise "Invalid sort column #{sortcolumn}" unless VALID_SORT_COLUMNS.include?(sortcolumn)

        job_listings.order({ sortcolumn => :desc })
      end
    end
  end
end
