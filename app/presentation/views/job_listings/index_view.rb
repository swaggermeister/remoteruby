# frozen_string_literal: true

module JobListings
  class IndexView
    include Shared::WebShared

    attr_reader :job_listings, :search_text, :paginator, :sortcolumn

    private

    def initialize(job_listings:, paginator:, search_text:, sortcolumn:)
      @job_listings = job_listings
      @paginator = paginator
      @search_text = search_text
      @sortcolumn = sortcolumn
    end

    public

    def job_listings?
      job_listings.any?
    end

    def title(job_listing)
      job_listing.title
    end

    def salary(job_listing)
      job_listing.salary
    end

    def employer_name(job_listing)
      job_listing.employer.name
    end

    def location(job_listing)
      job_listing.location
    end

    def avatar_url(job_listing)
      AvatarUrlBuilder.build(employer: job_listing.employer)
    end
  end
end
