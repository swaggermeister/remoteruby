# frozen_string_literal: true

class AddOmniAuthToEmployers < ActiveRecord::Migration[6.0]
  def change
    change_table :employers, bulk: true do |t|
      t.string :provider
      t.string :uid
    end
  end
end
