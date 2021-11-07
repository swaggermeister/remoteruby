# frozen_string_literal: true

module JobListings
  module UpdateUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(id:, attrs:)
        job_listing = find_job_listing(id: id)

        if (job_listing = update_job_listing(job_listing: job_listing, attrs: attrs))
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def find_job_listing(id:)
        JobListingsRepository.find(id: id)
      end

      def update_job_listing(job_listing:, attrs:)
        sanitize_salary_fields(attrs) if attrs[:minimum_salary].present?

        JobListingsRepository.update(id: job_listing.id, attrs: attrs)
      end

      def sanitize_salary_fields(attrs)
        attrs[:minimum_salary] = attrs[:minimum_salary].gsub(/[., $]/, "")
        attrs[:maximum_salary] = attrs[:maximum_salary].gsub(/[., $]/, "")
      end
    end
  end
end
