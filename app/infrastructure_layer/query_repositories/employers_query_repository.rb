# frozen_string_literal: true

module EmployersQueryRepository
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
        # attribute from the DB record, but actually
        # built from the avatar method on the AR record
        avatar: record.avatar,
      )

      # build an entity from the DB record's attributes
      Employer.new(**entity_build_attrs)
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
  end
end
