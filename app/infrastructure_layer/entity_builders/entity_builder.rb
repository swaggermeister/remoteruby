# frozen_string_literal: true

module EntityBuilder
  # Build a list of domain entities from each ActiveRecord object's attributes
  # def self.to_entities(entity_class:, attributes_for_records:)
  #   attributes_for_records.map do |attributes|
  #     to_entity(entity_class: entity_class, attributes: attributes)
  #   end
  # end

  # Build a domain entity from an ActiveRecord object's attributes
  def self.to_entity(entity_class:, attributes:)
    # Get the attributes of the ActiveRecord object
    # and convert them into a hash.
    # Then filter to the attributes on the entity
    filtered_attributes = attributes.symbolize_keys.slice(*entity_class::ATTRIBUTES)

    # Build entity from the filtered attributes
    entity_class.new(filtered_attributes)
  end
end
