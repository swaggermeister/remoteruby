# frozen_string_literal: true

module JobListings
  class ShowViewModel
    include Shared::WebShared

    delegate :contact_url, :contact_email, :location, :employer_id, :title, :minimum_salary, :maximum_salary, :fixed_amount, to: :job_listing

    attr_reader :job_listing, :search_text, :employer_num_job_listings

    private

    def initialize(current_employer:, job_listing:, search_text:, employer_num_job_listings:)
      @current_employer = current_employer
      @job_listing = job_listing
      @search_text = search_text
      @employer_num_job_listings = employer_num_job_listings
    end

    public

    # rubocop:disable Naming/PredicateName
    def has_contact_url?
      contact_url.present?
    end

    # rubocop:disable Rails/Delegate
    def contact_url
      job_listing.contact_url
    end

    # rubocop:enable Rails/Delegate

    def salary
      job_listing.fixed_amount.presence || "#{job_listing.minimum_salary.to_s(:currency, precision: 0)} - #{job_listing.maximum_salary.to_s(:currency, precision: 0)}"
    end

    # rubocop:disable Rails/Delegate
    def created_at
      job_listing.created_at
    end

    # rubocop:enable Rails/Delegate

    def is_own_listing?(signed_in_employer = nil)
      return false unless signed_in_employer

      job_listing.employer_id == signed_in_employer.id
    end

    def employer_name
      job_listing.employer.name
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
