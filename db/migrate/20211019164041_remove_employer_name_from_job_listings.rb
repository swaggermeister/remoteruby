# frozen_string_literal: true

class RemoveEmployerNameFromJobListings < ActiveRecord::Migration[6.0]
  def change
    safety_assured { remove_column :job_listings, :employer_name, :string }
  end
end
