# frozen_string_literal: true

module JobListings
  class ShowView
    include Shared::WebShared

    delegate :contact_url, :contact_email, :location, :employer_id, :title, :minimum_salary, :maximum_salary, :fixed_amount, to: :job_listing

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

    def salary
      job_listing.fixed_amount.presence || "#{job_listing.minimum_salary.to_s(:currency, precision: 0)} - #{job_listing.maximum_salary.to_s(:currency, precision: 0)}"
    end

    def created_at
      job_listing.created_at
    end

    def employer_name
      job_listing.employer.name
    end

    def number_jobs_posted
      job_listing.employer.job_listings.count
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
