# frozen_string_literal: true

module JobListingsCommandRepository
  class << self
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

    # TODO: destroy! instead of destroy
    def destroy(id:)
      JobListingRecord.destroy_by(id: id)
    end
  end
end
