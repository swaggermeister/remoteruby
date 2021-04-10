class AddIndexToSearchableColumnJobListings < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :job_listings, :searchable, using: :gin, algorithm: :concurrently
  end
end
