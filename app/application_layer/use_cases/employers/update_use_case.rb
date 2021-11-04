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
        EmployerRecord.find(id)
      end

      def update_employer(employer:, attrs:)
        # keep existing avatar if they didn't pick a new one
        employer.avatar.attach(attrs[:avatar]) if attrs[:avatar].present?

        employer.update(attrs)
      end
    end
  end
end
