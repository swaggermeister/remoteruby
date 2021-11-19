# frozen_string_literal: true

module Employers
  module EditQuery
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:)
        employer = find_employer(employers_repository: employers_repository, id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(employers_repository:, id:)
        # employer_attrs = employers_repository.find(id: id)
        employer = employers_repository.find(id: id)
        # ResultEmployer.new(**employer_attrs)
        # ResultEmployer.new(**employer_attrs.attributes)
        ResultEmployer.from_entity(employer)
      end
    end
  end
end
