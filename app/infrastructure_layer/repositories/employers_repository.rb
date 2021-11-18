# frozen_string_literal: true

module EmployersRepository
  class << self
    FIND_SQL_QUERY = <<-SQL.squish
    select
      id,
      name,
      email,
      created_at,
      updated_at
    from employers
    where id = :id
    limit 1
    SQL

    def find(id:)
      return nil if id.blank?

      # result = ActiveRecord::Base.connection.execute(
      #   ApplicationRecord.sanitize_sql([FIND_SQL_QUERY, { id: id }])
      # )

      # result.first
      # get the DB record
      record = EmployerRecord.find(id)

      entity_build_attrs = record.attributes.merge(
        # attach the avatar as well, since it's not an
        #  attribute from the DB record, but actually
        # built from the avatar method on the AR record
        avatar: record.avatar,
      )

      # build an entity from the DB record's attributes
      Employer.new(**entity_build_attrs)
    end

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

    EMAIL_TAKEN_SQL_QUERY = <<-SQL.squish
    select 1
    from employers
    where email = :email and id <> :employer_id
    limit 1
    SQL

    def email_taken?(employer_id:, email:)
      result = ActiveRecord::Base.connection.execute(
        ApplicationRecord.sanitize_sql([EMAIL_TAKEN_SQL_QUERY, { employer_id: employer_id, email: email }])
      )

      result.any?
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
