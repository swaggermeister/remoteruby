# frozen_string_literal: true

module Employers
  module UpdateCommand
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(employers_query_repository:, employers_command_repository:, id:, attrs:)
        # get the existing entity from the DB
        employer = find_employer_entity(employers_query_repository: employers_query_repository, id: id)

        # assign the new attributes
        employer.attributes = attrs
        employer.email_is_available = email_is_available?(employers_query_repository: employers_query_repository, employer_id: id, email: employer.email)

        employer = update_employer(
          employers_command_repository: employers_command_repository,
          employer: employer,
          avatar: attrs[:avatar],
        )

        # update the record in the DB
        if employer.valid?
          Result.new(success: true, employer: employer)
        else
          Result.new(success: false, employer: employer)
        end
      end

      private

      def find_employer_entity(employers_query_repository:, id:)
        # employer_attrs = employers_repository.find(id: id)
        employers_query_repository.find(id: id)
        # Employer.new(**employer_attrs)
        # ResultEmployer.from_entity(employer)
      end

      def update_employer(employers_command_repository:, employer:, avatar:)
        if avatar.present?
          # update the avatar
          employers_command_repository.set_avatar!(employer_id: employer.id, avatar: avatar)
        else
          # Unset the employer avatar attribute if it wasn't being updated
          employer.avatar = nil
        end

        # update the employer DB record
        employers_command_repository.update(entity: employer)
      end

      def email_is_available?(employers_query_repository:, employer_id:, email:)
        !employers_query_repository.email_taken?(employer_id: employer_id, email: email)
      end
    end
  end
end
