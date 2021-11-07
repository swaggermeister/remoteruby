# frozen_string_literal: true

module EmployersRepository
  class << self
    def find(id:)
      return nil if id.blank?

      record = EmployerRecord.find(id)
      EmployerEntityBuilder.to_entity(record: record)
    end

    def destroy(id:)
      EmployerRecord.destroy_by(id: id)
    end

    def update(id:, attrs:)
      record = EmployerRecord.find(id)
      record.update(attrs)
    end
  end
end
