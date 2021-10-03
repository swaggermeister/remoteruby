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
        sanitize_salary_fields(attrs) if attrs[:minimum_salary].present?

        JobListing.new(attrs.merge(employer_id: employer_id))
      end

      def sanitize_salary_fields(attrs)
        attrs[:minimum_salary] = attrs[:minimum_salary].gsub(/[., $]/, "")
        attrs[:maximum_salary] = attrs[:maximum_salary].gsub(/[., $]/, "")
      end
    end
  end
end
