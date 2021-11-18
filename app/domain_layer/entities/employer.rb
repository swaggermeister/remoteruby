# frozen_string_literal: true

class Employer
  GETTER_ATTRIBUTES = %i[id
                         created_at
                         updated_at
                         authenticatable_salt
                         avatar
                         name
                         password
                         password_confirmation
                         email
                         email_is_available].freeze

  SETTER_ATTRIBUTES = %i[
    name
    email
    avatar
    email_is_available
  ].freeze

  include EntityBehavior

  # Define validations in a re-usable module so that we
  # can also apply it to the ActiveRecord EmployerRecord
  # since Devise is so tightly coupled to it.
  # Then the devise controllers will work out of the box
  # with the validations
  module DatabaseValidations
    def self.included(klass)
      klass.instance_eval do
        validates :name, presence: true
        validates :email, presence: true
      end
    end
  end

  include DatabaseValidations
  validates :email_is_available, inclusion: { in: [true] }
end
