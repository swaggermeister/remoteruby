# frozen_string_literal: true

# # frozen_string_literal: true

module EntityBehavior
  def self.included(klass)
    klass.instance_eval do
      attr_reader(*klass::ATTRIBUTES)

      private

      attr_writer(*klass::ATTRIBUTES)
    end
  end

  # Define an initialize method
  # that loops over all of the attributes
  # and assigns to each of them from the args
  # equivalent to:
  #
  # self.name = attributes["name"]
  # self.age = attributes["age"]
  def initialize(**attributes)
    attributes.each do |name, value|
      public_send("#{name}=", value)
    end
  end
end
