# frozen_string_literal: true

module JobListings
  module NewUseCase
    Result = Struct.new(:job_listing, keyword_init: true)

    class << self
      def call
        job_listing = ResultJobListing.new

        Result.new(job_listing: job_listing)
      end
    end
  end
end
