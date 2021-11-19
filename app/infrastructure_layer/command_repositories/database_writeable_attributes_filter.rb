# frozen_string_literal: true

module DatabaseWriteableAttributesFilter
  # These attrs can be set on the database record
  # TODO: make sure updating an avatar works
  DB_WRITEABLE_ATTRIBUTES_EMPLOYER = %i[
    name
    email
    avatar
  ].freeze

  # These attrs can be set on the database record
  DB_WRITEABLE_ATTRIBUTES_JOB_LISTING = %i[
    employer_id
    title
    description
    location
    contact_email
    contact_url
    minimum_salary
    maximum_salary
    fixed_amount
  ].freeze

  class << self
    # Get an entity's DB writeable attributes as a hash
    def get_writeable_attributes(entity:)
      # rubocop:disable Layout/CaseIndentation
      writeable_attributes = case entity
        when Employer
          DB_WRITEABLE_ATTRIBUTES_EMPLOYER
        when JobListing
          DB_WRITEABLE_ATTRIBUTES_JOB_LISTING
        else
          raise "Could not determine DB writeable attributes for entity: #{entity}"
        end
      # rubocop:enable Layout/CaseIndentation

      entity.attributes.slice(*writeable_attributes)
    end
  end
end
