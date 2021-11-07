# frozen_string_literal: true

module Employers
  module DestroyUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(id:)
        if destroy_employer(id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_employer(id:)
        EmployersRepository.destroy(id: id)
      end
    end
  end
end
