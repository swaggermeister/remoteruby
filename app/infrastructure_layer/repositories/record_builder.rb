# frozen_string_literal: true

module RecordBuilder
  # Build a DB record by from an entity's attributes
  def self.from_entity(entity:, record_class:)
    # create a new DB record
    record = record_class.new

    # loop over the entity's attributes and assign
    # each to the record object
    entity.class::ATTRIBUTES.map do |attr|
      val = entity.public_send(attr)
      record.public_send("#{attr}=", val)
    end

    # return the hydrated record
    record
  end
end
