class AddTrigramIndexJobListingTitle < ActiveRecord::Migration[6.0]
  disable_ddl_transaction!

  def change
    add_index :job_listings,
              :title,
              opclass: :gin_trgm_ops,
              using: :gin,
              algorithm: :concurrently,
              name: "index_joblistings_on_title_trgm"
  end
end
