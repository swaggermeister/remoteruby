# frozen_string_literal: true

module JobListingsRepository
  class << self
    Pagination = Struct.new(:paginator, :job_listings, keyword_init: true)

    VALID_SORT_COLUMNS = %w[minimum_salary maximum_salary fixed_amount created_at].freeze

    include ::Pagy::Backend

    def list(query:, employer_id:, page_num:, sort_column:, pagination_count:)
      raise "Invalid sort column #{sort_column}" unless VALID_SORT_COLUMNS.include?(sort_column)

      # base scope
      scope = JobListingRecord.includes({ employer: :avatar_attachment }).order("#{sort_column} DESC NULLS LAST")

      # filter by employer
      scope = scope.where(employer_id: employer_id) if employer_id.present?

      # filter by query
      scope = if query.present?
          scope.search(query)
        else
          scope
        end

      paginator, job_listings = pagy(scope, items: pagination_count, page: page_num)

      Pagination.new(paginator: paginator, job_listings: JobListingEntityBuilder.to_entities(job_listings: job_listings))
    end

    def last_updated
      record = JobListingRecord.order(:updated_at).last

      JobListingEntityBuilder.to_entity(job_listing: record)
    end
  end
end
