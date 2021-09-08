# frozen_string_literal: true

class AddContactInfoToJobListings < ActiveRecord::Migration[6.0]
  def change
    change_table :job_listings, bulk: true do |t|
      t.string :contact_email
      t.string :contact_url
    end
  end
end
