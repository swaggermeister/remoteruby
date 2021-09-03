# frozen_string_literal: true

class AddEmployerNameToJobListings < ActiveRecord::Migration[6.0]
  def change
    add_column :job_listings, :employer_name, :string
  end
end
