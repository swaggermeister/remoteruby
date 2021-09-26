# frozen_string_literal: true

module JobListings
  class IndexView
    include Shared::WebShared

    attr_reader :job_listings, :search_text, :sort_column

    private

    attr_reader :paginator, :request

    def initialize(job_listings:, paginator:, search_text:, sort_column:, request:)
      @job_listings = job_listings
      @paginator = paginator
      @search_text = search_text
      @sort_column = sort_column
      @request = request
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

    def pagination_nav
      nav_builder = PaginationNavBuilder.new(paginator: paginator, request: request)
      nav_builder.build
    end

    def active_sort_button(sort_button)
      sort_button == sort_column ? "active" : ""
    end
  end
end
