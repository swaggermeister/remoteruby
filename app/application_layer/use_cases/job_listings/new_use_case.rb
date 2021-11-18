# frozen_string_literal: true

module JobListings
  module NewUseCase
    Result = Struct.new(:job_listing, keyword_init: true)

    class << self
      def call
        Result.new(job_listing: new_job_listing)
      end

      private

      def new_job_listing
        job_listing = JobListing.new
        ResultEntities::ResultJobListing.from_entity(job_listing)
      end
    end
  end
end
