# frozen_string_literal: true

module JobListings
  module MyCompanyUseCase
    Result = Struct.new(:job_listings, keyword_init: true)

    class << self
      def call(employer:)
        job_listings = employer.job_listings

        Result.new(
          job_listings: job_listings,
        )
      end
    end
  end
end
