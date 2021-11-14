# frozen_string_literal: true

module Employers
  module EditUseCase
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:)
        employer = find_employer(employers_repository: employers_repository, id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(employers_repository:, id:)
        employer_attrs = employers_repository.find(id: id)
        ResultEntities::ResultEmployer.new(employer_attrs)
      end
    end
  end
end
