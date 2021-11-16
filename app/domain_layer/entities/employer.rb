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

  validates :name, presence: true
  validates :email, presence: true
  validates :email_is_available, inclusion: { in: [true] }
end
