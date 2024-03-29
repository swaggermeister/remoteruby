# frozen_string_literal: true

class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
