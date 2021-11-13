# frozen_string_literal: true

module Employers
  module UpdateUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:, attrs:)
        # get the existing entity from the DB
        employer = find_employer(employers_repository: employers_repository, id: id)

        # assign the new attributes
        employer.attributes = attrs.merge(
          email_is_available: email_is_available?(email),
        )

        # update the record in the DB
        if update_employer(employers_repository: employers_repository, employer: employer)
          Result.new(success: true, employer: employer)
        else
          Result.new(success: false, employer: employer)
        end
      end

      private

      def find_employer(employers_repository:, id:)
        entity = employers_repository.find(id: id)
        ResultEntities::ResultEmployer.from_entity(entity)
      end

      def update_employer(employers_repository:, employer:, attrs:)
        # keep existing avatar if they didn't pick a new one
        employer.avatar.attach(attrs[:avatar]) if attrs[:avatar].present?

        employers_repository.update(id: employer.id, attrs: attrs)
      end

      def email_is_available?(email)
        !EmployersRepository.email_taken?(email)
      end
    end
  end
end
