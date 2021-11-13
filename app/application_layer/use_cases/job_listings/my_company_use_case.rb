# frozen_string_literal: true

module JobListings
  module MyCompanyUseCase
    Result = Struct.new(:job_listings, keyword_init: true)

    class << self
      def call(job_listings_repository:, employer_id:)
        job_listings = find_job_listings(job_listings_repository: job_listings_repository, employer_id: employer_id)

        Result.new(
          job_listings: job_listings,
        )
      end

      private

      def find_job_listings(job_listings_repository:, employer_id:)
        job_listings_repository.for_employer(id: employer_id)
      end
    end
  end
end
