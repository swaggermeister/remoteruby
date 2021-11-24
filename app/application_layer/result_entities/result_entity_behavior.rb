# frozen_string_literal: true

# Takes a domain entity's attributes
# and gives it ActiveModel-aware behavior
# for Rails helpers like form_for
module ResultEntityBehavior
  def self.included(klass)
    klass.instance_eval do
      # Act like an ActiveRecord model
      include ActiveModel::Model
      # Work with Rails path helpers
      include ActiveModel::Conversion

      # Getters and setters
      # Ideally we would only have getters so it acts more
      # like an immutable struct once constructed, but making this
      # behave like an ActiveModel object requires us to add
      # setters since ActiveModel expects every attribute to have
      # a setter in order to construct a new instance from a hash
      # of attributes
      attr_accessor(*(klass::ENTITY_CLASS::GETTER_ATTRIBUTES + [:errors]))

      extend ClassMethods
      # Prepend the instance methods so that the ones
      # we provide can override what is included by ActiveModel,
      # in the cases we need a different implementation than
      # the ActiveModel default
      prepend InstanceMethods
    end
  end

  module ClassMethods
    def from_entity(entity)
      attrs = entity.attributes
      filtered_attrs = attrs.slice(*(entity.class::GETTER_ATTRIBUTES + [:errors]))
      new(filtered_attrs)
    end
  end

  module InstanceMethods
    def model_name
      ActiveModel::Name.new(self.class::ENTITY_CLASS)
    end

    def attributes
      attributes = {}

      self.class::ENTITY_CLASS::ATTRIBUTES.each do |attribute|
        attributes[attribute] = public_send(attribute)
      end

      attributes
    end

    def [](key)
      attributes[key.intern]
    end

    def persisted?
      id.present?
    end

    def valid?
      errors.empty?
    end
  end
end
