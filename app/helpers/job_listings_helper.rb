# frozen_string_literal: true

module JobListingsHelper
  def show_email_input?(job_listing)
    job_listing.contact_url.blank?
  end

  def show_url_input?(job_listing)
    job_listing.contact_url.present?
  end
end
