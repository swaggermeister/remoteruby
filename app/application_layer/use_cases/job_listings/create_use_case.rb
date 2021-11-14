# frozen_string_literal: true

module JobListings
  module CreateUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(job_listings_repository:, attrs:, employer_id:)
        prepare_attributes!(attrs: attrs, employer_id: employer_id)
        job_listing = JobListing.new(**attrs)

        if (job_listing = create_job_listing(job_listings_repository: job_listings_repository, job_listing: job_listing))
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def create_job_listing(job_listings_repository:, job_listing:)
        created_job_listing = job_listings_repository.create(entity: job_listing)
        ResultEntities::ResultJobListing.from_entity(created_job_listing)
      end

      def prepare_attributes!(attrs:, employer_id:)
        attrs[:minimum_salary]&.gsub!(/[., $]/, "")
        attrs[:maximum_salary]&.gsub!(/[., $]/, "")
        attrs.merge!(employer_id: employer_id)
      end
    end
  end
end
