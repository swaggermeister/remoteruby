# frozen_string_literal: true

module JobListings
  class NewView
    include Shared::WebShared
    include Shared::FormShared
    include FormShared

    attr_reader :job_listing

    private

    # attr_reader :view_context

    def initialize(job_listing:)
      @job_listing = job_listing
      # @view_context = view_context
    end
  end
end
