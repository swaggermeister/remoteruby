# frozen_string_literal: true

class CreateJobListings < ActiveRecord::Migration[6.0]
  def change
    create_table :job_listings do |t|
      t.string :title
      t.text :description
      t.string :location
      t.string :salary

      t.timestamps
    end
  end
end
