# frozen_string_literal: true

class AddContactInfoToJobListings < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/BulkChangeTable
  def change
    add_column :job_listings, :contact_email, :string
    add_column :job_listings, :contact_url, :string
  end
  # rubocop:enable Rails/BulkChangeTable
end
