module Employers
  module DestroyUseCase
    Result = Struct.new(:success, :employer, keyword_init: true)

    class << self
      def call(id:)
        employer = find_employer(id: id)

        if employer.destroy
          Result.new(success: true)
        else
          Result.new(success: false, employer: employer)
        end
      end

      private

      def find_employer(id:)
        Employer.find(id)
      end
    end
  end
end
