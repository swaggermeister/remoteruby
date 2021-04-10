class AddSearchableToJobListing < ActiveRecord::Migration[6.0]
  def up
    sql = <<-SQLCODE
      ALTER TABLE job_listings
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
      setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
      setweight(to_tsvector('english', coalesce(description,'')), 'B') ) STORED;
    SQLCODE
    execute sql
  end

  def down
    remove_column :job_listings, :searchable
  end
end
