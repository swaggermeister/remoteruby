# frozen_string_literal: true

module ResultEntities
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

        # Getters
        attr_accessor(*klass::ENTITY_CLASS::GETTER_ATTRIBUTES)

        extend ClassMethods
        prepend InstanceMethods
      end
    end

    module ClassMethods
      def from_entity(entity)
        new(entity.attributes.slice(*entity.class::GETTER_ATTRIBUTES))
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
    end
  end
end
