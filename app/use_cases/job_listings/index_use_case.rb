# frozen_string_literal: true

module JobListings
  module IndexUseCase
    Result = Struct.new(:job_listings, :query, :sortcolumn, keyword_init: true)

    class << self
      def call(query:, sortcolumn:)
        query = query&.strip
        sortcolumn ||= 'created_at'

        job_listings = find_job_listings(query: query)
        job_listings = order_job_listings(job_listings: job_listings, sortcolumn: sortcolumn)

        Result.new(job_listings: job_listings, query: query, sortcolumn: sortcolumn)
      end

      private

      def find_job_listings(query:)
        scope = JobListing

        scope = if query.present?
                  scope.search(query)
                # query = query.where(["title ilike :search or description ilike :search", search: "%#{@search_text}%"])
                else
                  scope
                end

        scope.all
      end

      VALID_SORT_COLUMNS = %w[salary created_at].freeze

      def order_job_listings(job_listings:, sortcolumn:)
        raise "Invalid sort column #{sortcolumn}" unless VALID_SORT_COLUMNS.include?(sortcolumn)

        job_listings.order({ sortcolumn => :desc })
      end
    end
  end
end
