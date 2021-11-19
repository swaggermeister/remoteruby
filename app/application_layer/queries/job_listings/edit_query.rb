# frozen_string_literal: true

module JobListings
  module EditQuery
    Result = Struct.new(:job_listing, keyword_init: true)

    class << self
      def call(job_listings_repository:, id:)
        job_listing = find_job_listing(job_listings_repository: job_listings_repository, id: id)

        Result.new(job_listing: job_listing)
      end

      private

      def find_job_listing(job_listings_repository:, id:)
        entity = job_listings_repository.find(id: id)
        ResultJobListing.from_entity(entity)
      end
    end
  end
end
