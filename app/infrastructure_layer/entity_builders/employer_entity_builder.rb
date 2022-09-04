# frozen_string_literal: true

module EmployerEntityBuilder
  def self.to_entities(records:)
    records.map do |record|
      to_entity(record: record)
    end
  end

  def self.to_entity(record:)
    attributes = record.attributes
    attributes[:avatar] = record.avatar.attached? ? record.avatar : nil

    EntityBuilder.to_entity(entity_class: Employer, attributes: attributes)
  end
end
