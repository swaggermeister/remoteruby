module JobListings
  module EditUseCase
    Result = Struct.new(:job_listing, keyword_init: true)

    class << self
      def call(id:)
        job_listing = find_job_listing(id: id)

        Result.new(job_listing: job_listing)
      end

      private

      def find_job_listing(id:)
        JobListing.find(id)
      end
    end
  end
end
