module Employers
  module EditUseCase
    Result = Struct.new(:employer, keyword_init: true)

    class << self
      def call(id:)
        employer = find_employer(id: id)

        Result.new(employer: employer)
      end

      private

      def find_employer(id:)
        Employer.find(id)
      end
    end
  end
end
