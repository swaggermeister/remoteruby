# frozen_string_literal: true

module Employers
  module ShowUseCase
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(id:)
        employer = find_employer(id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(id:)
        EmployerRecord.find(id)
      end
    end
  end
end
