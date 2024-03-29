# frozen_string_literal: true

module JobListings
  module MyCompanyQuery
    Result = Struct.new(:job_listings, keyword_init: true)

    class << self
      def call(job_listings_query_repository:, employer_id:)
        job_listings = find_job_listings(job_listings_query_repository: job_listings_query_repository, employer_id: employer_id)

        Result.new(
          job_listings: job_listings,
        )
      end

      private

      def find_job_listings(job_listings_query_repository:, employer_id:)
        job_listings_query_repository.for_employer(id: employer_id).map! do |job_listing|
          ::ResultJobListing.from_entity(job_listing)
        end
      end
    end
  end
end
