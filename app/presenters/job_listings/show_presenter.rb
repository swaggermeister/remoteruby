# frozen_string_literal: true

module JobListings
  class ShowPresenter
    delegate :contact_url, :contact_email, :employer_name, :location, :title, :salary, to: :job_listing

    attr_reader :job_listing

    private

    def initialize(job_listing:)
      @job_listing = job_listing
    end

    public

    # rubocop:disable Naming/PredicateName
    def has_contact_url?
      contact_url.present?
    end

    # rubocop:enable Naming/PredicateName

    def description
      MarkdownConverter.markdown(job_listing.description)
    end
  end
end
