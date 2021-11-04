# frozen_string_literal: true

module EmployerEntityBuilder
  def self.to_entities(employers:)
    employers.map do |employer|
      to_entity(employer: employer)
    end
  end

  def self.to_entity(employer:)
    attributes = employer.attributes
    attributes[:avatar] = employer.avatar.attached? ? employer.avatar : nil

    EntityBuilder.to_entity(entity_class: Employer, attributes: attributes)
  end
end
