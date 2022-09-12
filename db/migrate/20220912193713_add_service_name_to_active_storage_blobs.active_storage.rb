# frozen_string_literal: true

# This migration comes from active_storage (originally 20190112182829)
class AddServiceNameToActiveStorageBlobs < ActiveRecord::Migration[6.0]
  def up
    return unless table_exists?(:active_storage_blobs)

    # rubocop:disable Style/GuardClause
    unless column_exists?(:active_storage_blobs, :service_name)
      add_column :active_storage_blobs, :service_name, :string

      # rubocop:disable Lint/AssignmentInCondition
      if configured_service = ActiveStorage::Blob.service.name
        # rubocop:disable Rails/SkipsModelValidations
        ActiveStorage::Blob.unscoped.update_all(service_name: configured_service)
        # rubocop:enable Rails/SkipsModelValidations
      end
      # rubocop:enable Lint/AssignmentInCondition

      safety_assured { change_column :active_storage_blobs, :service_name, :string, null: false }
    end
    # rubocop:enable Style/GuardClause
  end

  def down
    return unless table_exists?(:active_storage_blobs)

    remove_column :active_storage_blobs, :service_name
  end
end
