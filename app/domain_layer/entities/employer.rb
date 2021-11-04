# frozen_string_literal: true

class Employer
  ATTRIBUTES = %i[id
                  created_at
                  updated_at
                  avatar
                  name
                  email].freeze
  include EntityBehavior
end
