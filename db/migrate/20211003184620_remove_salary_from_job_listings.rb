# frozen_string_literal: true

class RemoveSalaryFromJobListings < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :job_listings, :salary, :string }
  end
end
