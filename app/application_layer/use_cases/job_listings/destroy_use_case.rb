# frozen_string_literal: true

module JobListings
  module DestroyUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(job_listings_repository:, id:)
        if destroy_job_listing(job_listings_repository: job_listings_repository, id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_job_listing(job_listings_repository:, id:)
        job_listings_repository.destroy(id: id)
      end
    end
  end
end
