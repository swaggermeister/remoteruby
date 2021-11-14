# frozen_string_literal: true

module EntityBehavior
  def self.included(klass)
    klass.instance_eval do
      # Validation support
      include ActiveModel::Validations
      # Provide ActiveModel identity methods like to_key
      include ActiveModel::Conversion

      # add an attribute for validation errors to be reported on
      attr_reader(*(klass::ATTRIBUTES + [:errors]))

      private

      attr_writer(*klass::WRITER_ATTRIBUTES)
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

  # returns a hash of all the attributes
  def attributes
    attrs = {}

    self.class::ATTRIBUTES.map do |attr_name|
      attrs[attr_name] = public_send(attr_name)
    end

    attrs
  end

  # returns a hash of all the writeable attributes on this entity
  def writeable_attributes
    attrs = {}

    self.class::WRITER_ATTRIBUTES.map do |attr_name|
      attrs[attr_name] = public_send(attr_name)
    end

    attrs
  end

  # assign new writeable attributes from a hash
  def attributes=(update_attrs)
    self.class::WRITER_ATTRIBUTES.each do |attr_name|
      if (val = update_attrs[attr_name])
        public_send("#{attr_name}=", val)
      end
    end
  end

  def persisted?
    id.present?
  end
end
