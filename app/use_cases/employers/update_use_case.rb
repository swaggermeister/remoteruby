# frozen_string_literal: true

module Employers
  module UpdateUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(id:, attrs:)
        employer = find_employer(id: id)

        if update_employer(employer: employer, attrs: attrs)
          Result.new(success: true, employer: employer)
        else
          Result.new(success: false, employer: employer)
        end
      end

      private

      def find_employer(id:)
        Employer.find(id)
      end

      def update_employer(employer:, attrs:)
        employer.update(attrs)
        employer.avatar.attach(attrs[:avatar])
      end
    end
  end
end
