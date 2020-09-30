class AddEmployerRefToJobListing < ActiveRecord::Migration[6.0]
  def change
    add_reference :job_listings, :employer, null: false, foreign_key: true
  end
end
