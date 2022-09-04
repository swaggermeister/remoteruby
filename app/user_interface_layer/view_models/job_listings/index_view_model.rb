# frozen_string_literal: true

module JobListings
  class IndexViewModel
    include Shared::WebShared

    attr_reader :job_listings, :search_text, :sort_column

    private

    attr_reader :paginator, :request, :filtering_by_employer

    def initialize(current_employer:, job_listings:, paginator:, search_text:, filtering_by_employer:, sort_column:, request:)
      @current_employer = current_employer
      @job_listings = job_listings
      @paginator = paginator
      @search_text = search_text
      @filtering_by_employer = filtering_by_employer
      @sort_column = sort_column
      @request = request
    end

    public

    def job_listings?
      job_listings.any?
    end

    def empty_state?
      job_listings.none? && search_text == "" && !filtering_by_employer
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

    def employer_name(job_listing)
      job_listing.employer.name
    end

    def filtering_by_employer?
      filtering_by_employer.present?
    end

    def filtering_by_employer_name
      filtering_by_employer.name
    end

    def filtering_by_employer_id
      return nil if filtering_by_employer.blank?

      filtering_by_employer.id
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
