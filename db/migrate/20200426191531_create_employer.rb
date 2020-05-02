class CreateEmployer < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :name
      t.string :email
      t.string :username
      t.string :password
    end
  end
end
