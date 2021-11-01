# frozen_string_literal: true

module EmployersRepository
  def self.find(id:)
    return nil if id.blank?

    Employer.find(id)
  end
end
