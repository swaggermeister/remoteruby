# frozen_string_literal: true

module JobListingEntityBuilder
  def self.to_entities(job_listings:)
    job_listings.map do |job_listing|
      to_entity(job_listing: job_listing)
    end
  end

  def self.to_entity(job_listing:)
    return nil if job_listing.nil?

    # Get the record attributes
    attributes = job_listing.attributes

    # Build the associations
    employer_entity = EmployerEntityBuilder.to_entity(employer: job_listing.employer)

    # Add the association entities to the attributes list
    attributes[:employer] = employer_entity

    EntityBuilder.to_entity(entity_class: JobListing, attributes: attributes)
  end
end
