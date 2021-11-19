# frozen_string_literal: true

module JobListings
  module DestroyCommand
    Result = Struct.new(:success, :job_listing, keyword_init: true)

    class << self
      def call(job_listings_command_repository:, id:)
        if destroy_job_listing(job_listings_command_repository: job_listings_command_repository, id: id)
          Result.new(success: true)
        else
          Result.new(success: false)
        end
      end

      private

      def destroy_job_listing(job_listings_command_repository:, id:)
        job_listings_command_repository.destroy(id: id)
      end
    end
  end
end
