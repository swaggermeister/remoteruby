# frozen_string_literal: true

class JobListing < ApplicationRecord
  include PgSearch::Model
  belongs_to :employer
  validates :title, :description, :location, :salary, presence: true
  validate :contact_email_or_url

  pg_search_scope :search,
                  against: { title: 'A', description: 'B' },
                  using: {
                    tsearch: {
                      dictionary: 'english',
                      tsvector_column: 'searchable',
                      prefix: true
                    }
                  }

  def contact_email_or_url
    return if :contact_email.present? || :contact_url.present?

    errors.add(:contact_email,
               'Please add a contact email or URL')
  end
end
