# frozen_string_literal: true

module JobListings
  class ShowView
    include Shared::WebShared

    delegate :contact_url, :contact_email, :employer_name, :location, :title, :salary, to: :job_listing

    attr_reader :job_listing, :search_text

    private

    def initialize(job_listing:, search_text:)
      @job_listing = job_listing
      @search_text = search_text
    end

    public

    # rubocop:disable Naming/PredicateName
    def has_contact_url?
      contact_url.present?
    end

    def contact_url
      job_listing.contact_url
    end

    # rubocop:enable Naming/PredicateName

    def description
      MarkdownConverter.markdown(job_listing.description)
    end

    def avatar_url
      AvatarUrlBuilder.build(employer: job_listing.employer)
    end
  end
end