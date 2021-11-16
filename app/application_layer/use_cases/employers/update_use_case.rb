# frozen_string_literal: true

module Employers
  module UpdateUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:, attrs:)
        # get the existing entity from the DB
        employer = find_employer_entity(employers_repository: employers_repository, id: id)

        # assign the new attributes
        employer.attributes = attrs
        employer.email_is_available = email_is_available?(employer_id: id, email: employer.email)

        employer = update_employer(
          employers_repository: employers_repository,
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

      def find_employer_entity(employers_repository:, id:)
        # employer_attrs = employers_repository.find(id: id)
        employers_repository.find(id: id)
        # Employer.new(**employer_attrs)
        # ResultEntities::ResultEmployer.from_entity(employer)
      end

      def update_employer(employers_repository:, employer:, avatar:)
        # update the avatar
        employers_repository.set_avatar!(employer_id: employer.id, avatar: avatar)

        # update the employer DB record
        employers_repository.update(entity: employer)
      end

      def email_is_available?(email)
        !EmployersRepository.email_taken?(email)
      end
    end
  end
end
