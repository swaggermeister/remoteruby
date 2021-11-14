# frozen_string_literal: true

module JobListings
  class EditViewModel
    include Shared::WebShared
    include Shared::FormShared
    include FormShared

    attr_reader :job_listing

    private

    def initialize(current_employer:, job_listing:)
      @current_employer = current_employer
      @job_listing = job_listing
    end
  end
end
