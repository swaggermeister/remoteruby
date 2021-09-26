class AddSalaryRangeFieldsToJobListings < ActiveRecord::Migration[6.0]
  def change
    safety_assured {
      change_table :job_listings, bulk: true do |t|
        t.integer :minimum_salary
        t.integer :maximum_salary
      end
    }
  end
end
