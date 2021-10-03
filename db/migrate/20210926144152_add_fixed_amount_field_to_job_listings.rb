# frozen_string_literal: true

class AddFixedAmountFieldToJobListings < ActiveRecord::Migration[6.0]
  def change
    add_column :job_listings, :fixed_amount, :string
  end
end
