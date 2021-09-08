# frozen_string_literal: true

module JobListings
  class EditPresenter
    include FormShared

    attr_reader :job_listing

    private

    def initialize(job_listing:)
      @job_listing = job_listing
    end

    # public
  end
end
