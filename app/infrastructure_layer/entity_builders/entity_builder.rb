# frozen_string_literal: true

module EntityBuilder
  # Build a domain entity from an ActiveRecord object's attributes
  def self.to_entity(entity_class:, attributes:)
    # Get the attributes of the ActiveRecord object
    # and convert them into a hash.
    # Then filter to the attributes on the entity
    filtered_attributes = attributes.symbolize_keys.slice(*entity_class::GETTER_ATTRIBUTES)

    # Build entity from the filtered attributes
    entity_class.new(**filtered_attributes)
  end
end
