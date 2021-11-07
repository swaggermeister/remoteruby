# frozen_string_literal: true

module JobListingEntityBuilder
  def self.to_entities(records:)
    records.map do |record|
      to_entity(record: record)
    end
  end

  def self.to_entity(record:)
    return nil if record.nil?

    # Get the record attributes
    attributes = record.attributes

    # Build the associations
    employer_entity = EmployerEntityBuilder.to_entity(record: record.employer)

    # Add the association entities to the attributes list
    attributes[:employer] = employer_entity

    EntityBuilder.to_entity(entity_class: JobListing, attributes: attributes)
  end
end
