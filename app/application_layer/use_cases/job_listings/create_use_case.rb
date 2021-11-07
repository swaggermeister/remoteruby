# frozen_string_literal: true

module JobListings
  module CreateUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(attrs:, employer_id:)
        attrs = prepare_attributes(attrs: attrs, employer_id: employer_id)

        if job_listing = create_job_listing(attrs: attrs)
          Result.new(success: true, job_listing: job_listing)
        else
          Result.new(success: false, job_listing: job_listing)
        end
      end

      private

      def create_job_listing(attrs:)
        entity = JobListingsRepository.create(attrs: attrs)
        ResultJobListing.from_entity(entity)
      end

      def prepare_attributes(attrs:, employer_id:)
        attrs[:minimum_salary]&.gsub!(/[., $]/, "")
        attrs[:maximum_salary]&.gsub!(/[., $]/, "")
        attrs.merge!(employer_id: employer_id)
      end
    end
  end
end
