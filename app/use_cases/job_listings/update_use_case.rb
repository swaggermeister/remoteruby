module JobListings
  module UpdateUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(id:, attrs:)
        job_listing = find_job_listing(id: id)

        if update_job_listing(job_listing: job_listing, attrs: attrs)
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def find_job_listing(id:)
        JobListing.find(id)
      end

      def update_job_listing(job_listing:, attrs:)
        job_listing.update(attrs)
      end
    end
  end
end
