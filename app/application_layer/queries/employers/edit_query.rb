# frozen_string_literal: true

module Employers
  module EditQuery
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(employers_query_repository:, id:)
        employer = find_employer(employers_query_repository: employers_query_repository, id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(employers_query_repository:, id:)
        employer = employers_query_repository.find(id: id)
        ResultEmployer.from_entity(employer)
      end
    end
  end
end
