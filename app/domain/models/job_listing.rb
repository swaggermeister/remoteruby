# frozen_string_literal: true

class JobListing < ApplicationRecord
  include PgSearch::Model
  belongs_to :employer
  validates :title, :description, :location, :salary, presence: true
  validate :validate_contact_email_or_url
  validate :validate_contact_url_format

  pg_search_scope :search,
                  against: { title: "A", description: "B" },
                  using: {
                    tsearch: {
                      dictionary: "english",
                      tsvector_column: "searchable",
                      prefix: true
                    }
                  }

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
end
