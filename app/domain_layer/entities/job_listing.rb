# frozen_string_literal: true

class JobListing
  ATTRIBUTES = %i[id
                  created_at
                  updated_at
                  employer_id
                  employer
                  title
                  description
                  location
                  contact_email
                  contact_url
                  minimum_salary
                  maximum_salary
                  fixed_amount].freeze

  include EntityBehavior
end
