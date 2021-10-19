# frozen_string_literal: true

module JobListings
  class IndexView
    include Shared::WebShared

    attr_reader :job_listings, :employer_id, :search_text, :sort_column

    private

    attr_reader :paginator, :request

    # rubocop:disable Metrics/ParameterLists
    def initialize(job_listings:, paginator:, search_text:, employer_id:, sort_column:, request:)
      @job_listings = job_listings
      @paginator = paginator
      @search_text = search_text
      @employer_id = employer_id
      @sort_column = sort_column
      @request = request
    end

    # rubocop:enable Metrics/ParameterLists

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
      job_listing.fixed_amount.presence || "#{job_listing.minimum_salary.to_s(:currency, precision: 0)} - #{job_listing.maximum_salary.to_s(:currency, precision: 0)}"
    end

    def employer_name(job_listing = nil)
      if job_listing.nil?
        Employer.find(employer_id).name
      else
        job_listing.employer.name
      end
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
