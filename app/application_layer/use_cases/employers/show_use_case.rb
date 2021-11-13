# frozen_string_literal: true

module Employers
  module ShowUseCase
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:)
        employer = find_employer(employers_repository: employers_repository, id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(employers_repository:, id:)
        entity = employers_repository.find(id: id)
        ResultEntities::ResultEmployer.from_entity(entity)
      end
    end
  end
end
