class RemovePasswordDigestFromEmployers < ActiveRecord::Migration[6.0]
  def change
    remove_column :employers, :password, :string
    remove_column :employers, :password_digest, :string
  end
end
