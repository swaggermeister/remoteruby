class RenameEmployerPasswordColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :employers, :password, :password_digest
  end
end
