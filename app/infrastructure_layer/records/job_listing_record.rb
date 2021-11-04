# frozen_string_literal: true

class JobListingRecord < ApplicationRecord
  self.table_name = "job_listings"

  include PgSearch::Model
  pg_search_scope :search,
                  against: { title: "A", description: "B" },
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "searchable",
                      prefix: true,
                    },
                  }

  belongs_to :employer, class_name: "EmployerRecord"

  validates :title, :description, :location, presence: true
  validate :validate_contact_email_or_url
  validate :validate_contact_url_format
  validate :validate_salary_range_or_hourly_amount_present
  validate :validate_salary_range

  private

  def validate_contact_email_or_url
    return if contact_email.present? || contact_url.present?

    errors.add(:contact_email,
               "Please add a contact email or URL")
  end

  def validate_contact_url_format
    return if contact_email.present? || UrlFormatValidator.valid?(url: contact_url)

    errors.add(:contact_url,
               "must start with https:// or http://")
  end

  def validate_salary_range_or_hourly_amount_present
    return if (minimum_salary.present? && maximum_salary.present?) || fixed_amount.present?

    errors.add(:minimum_salary, "Please add a salary range or hourly/fixed amount.")
  end

  def validate_salary_range
    return if fixed_amount.present?
    return if minimum_salary < maximum_salary

    errors.add(:minimum_salary, "must be less than the maximum salary.")
  end
end