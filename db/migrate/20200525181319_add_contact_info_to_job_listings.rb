class AddContactInfoToJobListings < ActiveRecord::Migration[6.0]
  def change
    add_column :job_listings, :contact_email, :string
    add_column :job_listings, :contact_url, :string
  end
end
