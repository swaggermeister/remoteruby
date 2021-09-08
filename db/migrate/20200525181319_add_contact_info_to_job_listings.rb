# frozen_string_literal: true

class AddContactInfoToJobListings < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Rails/BulkChangeTable
    add_column :job_listings, :contact_email, :string
    add_column :job_listings, :contact_url, :string
    # rubocop:enable Rails/BulkChangeTable
  end
end
