# frozen_string_literal: true

module Employers
  module DestroyCommand
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(employers_command_repository:, id:)
        if destroy_employer(employers_command_repository: employers_command_repository, id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_employer(employers_command_repository:, id:)
        employers_command_repository.destroy(id: id)
      end
    end
  end
end
