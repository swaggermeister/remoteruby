# frozen_string_literal: true
# # frozen_string_literal: true

# module RecordBuilder
#   class << self
#     # Build a DB record by from an entity's attributes
#     def from_entity(entity:, record_class:)
#       # create a new DB record
#       record = record_class.new

#       # loop over the entity's attributes and assign
#       # each to the record object
#       entity.class::ATTRIBUTES.map do |attr_val|
#         val = entity.public_send(attr_val)
#         setter_method_name = "#{attr_val}="
#         record.public_send(setter_method_name, build_record_attr_val(val)) if record.respond_to?(setter_method_name)
#       end

#       # return the hydrated record
#       record
#     end

#     private

#     # Recursively handle associations
#     def build_record_attr_val(val)
#       case val
#       when Employer, JobListing
#         record_class = record_class_for_entity(val)
#         from_entity(entity: val, record_class: record_class)
#       else
#         val
#       end
#     end

#     def record_class_for_entity(entity)
#       case entity
#       when Employer
#         EmployerRecord
#       when JobListing
#         JobListingRecord
#       else
#         raise "No record class mapping for entity #{entity}"
#       end
#     end
#   end
# end
