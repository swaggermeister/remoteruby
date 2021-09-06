# frozen_string_literal: true

class AddDeviseToEmployers < ActiveRecord::Migration[6.0]
  # rubocop:disable Rails/BulkChangeTable
  # rubocop:disable Metrics/AbcSize
  def self.up
    change_table :employers do |t|
      ## Database authenticatable
      t.change :email, :string, null: false, default: ''
      t.string :encrypted_password, null: false, default: ''

      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip

      ## Confirmable
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      t.integer :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      t.string :unlock_token # Only if unlock strategy is :email or :both
      t.datetime :locked_at

      # Uncomment below if timestamps were not included in your original model.
      # t.timestamps null: false
    end

    add_index :employers, :email, unique: true
    add_index :employers, :reset_password_token, unique: true
    add_index :employers, :confirmation_token, unique: true
    add_index :employers, :unlock_token, unique: true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    # raise ActiveRecord::IrreversibleMigration
    change_table(:employers) do |t|
      t.remove :encrypted_password

      ## Recoverable
      t.remove :reset_password_token
      t.remove :reset_password_sent_at

      ## Rememberable
      t.remove :remember_created_at

      ## Trackable
      t.remove :sign_in_count
      t.remove :current_sign_in_at
      t.remove :last_sign_in_at
      t.remove :current_sign_in_ip
      t.remove :last_sign_in_ip

      ## Confirmable
      t.remove :confirmation_token
      t.remove :confirmed_at
      t.remove :confirmation_sent_at
      t.remove :unconfirmed_email

      ## Lockable
      t.remove :failed_attempts
      t.remove :unlock_token
      t.remove :locked_at
    end
  end
  # rubocop:enable Rails/BulkChangeTable
  # rubocop:enable Metrics/AbcSize
end
