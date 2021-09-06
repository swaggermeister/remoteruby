# frozen_string_literal: true

module JobListings
  module IndexUseCase
    Result = Struct.new(:job_listings, :query, keyword_init: true)

    class << self
      def call(query:)
        query = query&.strip
        job_listings = find_job_listings(query: query)

        Result.new(job_listings: job_listings, query: query)
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
    end
  end
end
