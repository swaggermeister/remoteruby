# frozen_string_literal: true

class Employer
  ATTRIBUTES = %i[id
                  created_at
                  updated_at
                  authenticatable_salt
                  avatar
                  name
                  password
                  password_confirmation
                  email
                  email_is_available].freeze

  # TODO: make sure updating an avatar works
  WRITER_ATTRIBUTES = %i[
    name
    email
    avatar
  ].freeze

  include EntityBehavior

  validates :name, presence: true
  validates :email, presence: true
  validates :email_is_available, inclusion: { in: [true] }
end
