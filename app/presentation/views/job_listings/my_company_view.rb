# frozen_string_literal: true

module JobListings
  class MyCompanyView
    include Shared::WebShared

    attr_reader :job_listings

    private

    def initialize(job_listings:)
      @job_listings = job_listings
    end

    public

    def job_listings?
      job_listings.any?
    end

    def title(job_listing)
      job_listing.title
    end

    def minimum_salary(job_listing)
      job_listing.minimum_salary
    end

    def maximum_salary(job_listing)
      job_listing.maximum_salary
    end

    def salary(job_listing)
      job_listing.salary.presence || "$#{job_listing.minimum_salary} - $#{job_listing.maximum_salary}"
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
