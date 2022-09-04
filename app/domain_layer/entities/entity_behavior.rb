# frozen_string_literal: true

module EntityBehavior
  def self.included(klass)
    klass.instance_eval do
      # Validation support
      include ActiveModel::Validations
      # Provide ActiveModel identity methods like to_key
      include ActiveModel::Conversion

      # Define getters and setters
      # Also add an attribute for validation errors to be reported on
      attr_reader(*(klass::GETTER_ATTRIBUTES + [:errors]))

      private

      attr_writer(*(klass::SETTER_ATTRIBUTES + [:errors]))
    end
  end

  # Define an initialize method
  # that loops over all of the attributes
  # and assigns to each of them from the args
  # equivalent to:
  #
  # @name = attributes["name"]
  # @age = attributes["age"]
  def initialize(**attributes)
    @errors = ActiveModel::Errors.new(self)

    attributes.each do |name, value|
      instance_variable_set("@#{name}".intern, value)
    end
  end

  # Returns a hash of all the getter attributes
  def attributes
    attrs = {}

    (self.class::GETTER_ATTRIBUTES + [:errors]).map do |attr_name|
      attrs[attr_name] = public_send(attr_name)
    end

    attrs
  end

  # Mass-assign new setter attributes from a hash
  def attributes=(update_attrs)
    self.class::SETTER_ATTRIBUTES.each do |attr_name|
      if (val = update_attrs[attr_name])
        public_send("#{attr_name}=", val)
      end
    end
  end

  # Is the record new or has it already been persisted?
  def persisted?
    id.present?
  end
end
