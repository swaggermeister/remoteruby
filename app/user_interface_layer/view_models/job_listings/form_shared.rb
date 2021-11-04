# frozen_string_literal: true

module JobListings
  module FormShared
    def show_email_input?
      job_listing.contact_url.blank?
    end

    def show_url_input?
      job_listing.contact_url.present?
    end

    def show_salary_range?
      job_listing.fixed_amount.blank?
    end

    def show_hourly_amount?
      job_listing.fixed_amount.present?
    end

    def submit_button_text
      job_listing.new_record? ? "Create Listing" : "Update Listing"
    end
  end
end