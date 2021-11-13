# frozen_string_literal: true

module EntityBehavior
  def self.included(klass)
    klass.instance_eval do
      # Validation support
      include ActiveModel::Validations

      attr_reader(*klass::ATTRIBUTES)

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
    # add an attribute for validation errors to be reported on
    attributes.merge!(:errors)

    attributes.each do |name, value|
      instance_variable_set("@#{name}".intern, value)
    end
  end

  # returns a hash of all the attributes
  def attributes
    attrs = {}

    entity.class::ATTRIBUTES.map do |name|
      attrs[name] = entity.public_send(attr)
    end

    attrs
  end

  def attributes=(**update_attrs)
    self.class::WRITER_ATTRIBUTES.each do |attr_name|
      if (val = update_attrs[attr_name])
        public_send("#{attr_name}=", val)
      end
    end
  end
end
