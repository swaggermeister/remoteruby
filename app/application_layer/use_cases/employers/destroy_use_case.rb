# frozen_string_literal: true

module Employers
  module DestroyUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(employers_repository:, id:)
        if destroy_employer(employers_repository: employers_repository, id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_employer(employers_repository:, id:)
        employers_repository.destroy(id: id)
      end
    end
  end
end
