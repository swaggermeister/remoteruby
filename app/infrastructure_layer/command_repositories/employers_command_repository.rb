# frozen_string_literal: true

module EmployersCommandRepository
  class << self
    # TODO: destroy! instead of destroy
    def destroy(id:)
      EmployerRecord.destroy_by(id: id)
    end

    # TODO: update! instead of update
    # Update the DB record, then return the entity back.
    # If it wasn't valid, the entity's ActiveRecord-style
    # errors attribute will be populated
    def update(entity:)
      # update the DB record if the entity is valid
      if entity.valid?
        # get the existing DB record
        record = EmployerRecord.find(entity.id)

        # get a hash of attributes to update in the DB
        update_attrs = DatabaseWriteableAttributesFilter.get_writeable_attributes(entity: entity)

        # update DB record
        record.update!(update_attrs)
      end

      entity
    end

    def set_avatar!(employer_id:, avatar:)
      # keep existing avatar if they didn't pick a new one
      return false if avatar.blank?

      record = EmployerRecord.find(employer_id)

      # attach the avatar with ActiveStorage
      record.avatar.attach(avatar)
      true
    end
  end
end
