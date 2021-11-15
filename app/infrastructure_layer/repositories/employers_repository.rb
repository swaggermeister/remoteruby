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

      result = ActiveRecord::Base.connection.execute(
        ApplicationRecord.sanitize_sql([FIND_SQL_QUERY, { id: id }])
      )

      result.first
    end

    def destroy(id:)
      EmployerRecord.destroy_by(id: id)
    end

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

        # update
        record.update!(update_attrs)

        # build the entity from the updated DB record
        Employer.new(**record.attributes)
      else
        entity
      end
    end

    EMAIL_TAKEN_SQL_QUERY = <<-SQL.squish
    select 1
    from employers
    where email = :email
    limit 1
    SQL

    def email_taken?(email)
      result = ActiveRecord::Base.connection.execute(
        ApplicationRecord.sanitize_sql([EMAIL_TAKEN_SQL_QUERY, { email: email }])
      )

      result.any?
    end
  end
end
