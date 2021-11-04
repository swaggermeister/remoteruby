# frozen_string_literal: true

module JobListings
  module DestroyUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(id:)
        job_listing = find_job_listing(id: id)

        if job_listing.destroy
          Result.new(success: true)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def find_job_listing(id:)
        JobListingRecord.find(id)
      end
    end
  end
end
