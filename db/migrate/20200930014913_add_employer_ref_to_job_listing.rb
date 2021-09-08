# frozen_string_literal: true

class AddEmployerRefToJobListing < ActiveRecord::Migration[6.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_reference :job_listings, :employer, null: false, foreign_key: true
    # rubocop:enable Rails/NotNullColumn
  end
end
