# frozen_string_literal: true

module EmployersRepository
  class << self
    FIND_SQL_QUERY = <<-SQL.squish
    select
      id,
      name,
      email,
      created_at,
      updated_at,
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

    def update(entity:)
      # update the DB record if the entity is valid
      if entity.valid?
        record = RecordBuilder.from_entity(entity: entity, record_class: EmployerRecord)
        record.update!(attrs)
      end

      # return the entity back. if it wasn't valid,
      # the entity's ActiveRecord style errors attribute will be populated
      entity
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
