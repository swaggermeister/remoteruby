# frozen_string_literal: true

module JobListings
  module IndexUseCase
    PAGINATION_COUNT = 15

    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)
    Result = Struct.new(:paginator, :job_listings, :query, keyword_init: true)

    class << self
      include ::Pagy::Backend

      def call(query:, page_num:)
        query = query&.strip
        pagination = find_paginated_job_listings(query: query, page_num: page_num)

        Result.new(paginator: pagination.paginator, job_listings: pagination.job_listings, query: query)
      end

      private

      def find_paginated_job_listings(query:, page_num:)
        scope = JobListing

        scope = if query.present?
            scope.search(query)
            # query = query.where(["title ilike :search or description ilike :search", search: "%#{@search_text}%"])
          else
            scope
          end

        paginator, job_listings = pagy(scope, items: PAGINATION_COUNT, page: page_num)

        Pagination.new(paginator: paginator, job_listings: job_listings)
      end
    end
  end
end
