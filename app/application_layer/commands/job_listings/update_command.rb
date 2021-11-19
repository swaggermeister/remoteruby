# frozen_string_literal: true

module JobListings
  module UpdateCommand
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(job_listings_repository:, id:, attrs:)
        # get the existing job listing from the DB
        job_listing = find_job_listing(job_listings_repository: job_listings_repository, id: id)

        # set new attributes from the user
        sanitize_salary_attrs!(attrs)
        job_listing.attributes = attrs

        # update it in the DB
        job_listing = update_job_listing(job_listings_repository: job_listings_repository, job_listing: job_listing)

        if job_listing.valid?
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def find_job_listing(job_listings_repository:, id:)
        job_listings_repository.find(id: id)
      end

      def update_job_listing(job_listings_repository:, job_listing:)
        job_listings_repository.update(entity: job_listing)
      end

      def sanitize_salary_attrs!(attrs)
        attrs[:minimum_salary] = attrs[:minimum_salary].gsub(/[., $]/, "") if attrs[:minimum_salary].present?
        attrs[:maximum_salary] = attrs[:maximum_salary].gsub(/[., $]/, "") if attrs[:maximum_salary].present?
      end
    end
  end
end
