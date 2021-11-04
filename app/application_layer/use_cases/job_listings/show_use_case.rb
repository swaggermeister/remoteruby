# frozen_string_literal: true

module JobListings
  module ShowUseCase
    Result = Struct.new(:job_listing, :search_text, keyword_init: true)

    class << self
      def call(id:, search_text:)
        search_text ||= ""
        search_text = search_text.strip

        job_listing = find_job_listing(id: id)

        Result.new(job_listing: job_listing, search_text: search_text)
      end

      private

      def find_job_listing(id:)
        JobListingRecord.find(id)
      end
    end
  end
end
