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

      Pagination.new(paginator: paginator, job_listings: JobListingEntityBuilder.to_entities(records: job_listings))
    end

    def last_updated
      record = JobListingRecord.order(:updated_at).last

      JobListingEntityBuilder.to_entity(record: record)
    end

    def find(id:)
      record = JobListingRecord.find(id)
      JobListingEntityBuilder.to_entity(record: record)
    end

    # TODO: update! instead of update
    # Update the DB record, then return the entity back.
    # If it wasn't valid, the entity's ActiveRecord-style
    # errors attribute will be populated
    def update(entity:)
      # update the DB record if the entity is valid
      if entity.valid?
        # get the existing DB record
        record = JobListingRecord.find(entity.id)

        # get a hash of attributes to update in the DB
        update_attrs = DatabaseWriteableAttributesFilter.get_writeable_attributes(entity: entity)

        # update in the DB
        record.update!(update_attrs)

        # build the entity from the updated DB record
        JobListing.new(**record.attributes)
      end

      entity
    end

    # TODO: create! instead of create
    # Create the DB record, then return the entity back.
    # If it wasn't valid, the entity's ActiveRecord-style
    # errors attribute will be populated
    def create(entity:)
      # create the DB record if the entity is valid
      if entity.valid?
        # get a hash of attributes to update in the DB
        create_attrs = DatabaseWriteableAttributesFilter.get_writeable_attributes(entity: entity)

        # create in the DB
        record = JobListingRecord.create!(create_attrs)

        # build the entity from the created DB record
        JobListing.new(**record.attributes)
      else
        entity
      end
    end

    def job_listing_count_for_employer(employer_id:)
      query = "select count(id) from job_listings where employer_id = :employer_id"

      result = ActiveRecord::Base.connection.execute(
        ApplicationRecord.sanitize_sql([query, { employer_id: employer_id }])
      )

      result.getvalue(0, 0)
    end

    # TODO: destroy! instead of destroy
    def destroy(id:)
      JobListingRecord.destroy_by(id: id)
    end

    def for_employer(id:)
      JobListingRecord.where(employer_id: id).all.map do |job_listing_record|
        JobListingEntityBuilder.to_entity(record: job_listing_record)
      end
    end
  end
end
