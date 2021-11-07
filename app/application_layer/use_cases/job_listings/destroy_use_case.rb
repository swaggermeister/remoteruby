# frozen_string_literal: true

module JobListings
  module DestroyUseCase
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(id:)
        if destroy_job_listing(id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_job_listing(id:)
        JobListingsRepository.destroy(id: id)
      end
    end
  end
end
