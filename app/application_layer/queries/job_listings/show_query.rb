# frozen_string_literal: true

module JobListings
  module ShowQuery
    Result = Struct.new(:job_listing, :search_text, :employer_num_job_listings, keyword_init: true)

    class << self
      def call(job_listings_query_repository:, id:, search_text:)
        search_text ||= ""
        search_text = search_text.strip

        job_listing = find_job_listing(job_listings_query_repository: job_listings_query_repository, id: id)
        employer_num_job_listings = find_employer_num_job_listings(job_listings_query_repository: job_listings_query_repository, job_listing: job_listing)

        Result.new(
          job_listing: job_listing,
          search_text: search_text,
          employer_num_job_listings: employer_num_job_listings,
        )
      end

      private

      def find_employer_num_job_listings(job_listings_query_repository:, job_listing:)
        job_listings_query_repository.job_listing_count_for_employer(employer_id: job_listing.employer_id)
      end

      def find_job_listing(job_listings_query_repository:, id:)
        entity = job_listings_query_repository.find(id: id)
        ResultJobListing.from_entity(entity)
      end
    end
  end
end
