# frozen_string_literal: true

module JobListings
  module CreateUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(attrs:, employer_id:)
        job_listing = build_job_listing(attrs: attrs, employer_id: employer_id)

        if job_listing.save
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def build_job_listing(attrs:, employer_id:)
        JobListing.new(attrs.merge(employer_id: employer_id))
      end
    end
  end
end
