# frozen_string_literal: true

module EmployersRepository
  class << self
    def find(id:)
      return nil if id.blank?

      record = EmployerRecord.find(id)

      EmployerEntityBuilder.to_entity(employer: record)
    end
  end
end
