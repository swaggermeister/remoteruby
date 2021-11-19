# frozen_string_literal: true

require_relative "boot"

# Manually require Rails pieces so that we can remove
# extra dependencies and save on RAM usage
require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
# require "action_mailbox/engine" # Not receiving inbound emails right now
# require "action_text/engine" # We're not using ActionText rich text fields
require "action_view/railtie"
# require "action_cable/engine" # ActionCable is not used
# require "sprockets/railtie" # Sprockets isn't used since we're using Webpacker
require "rails/test_unit/railtie"
require("dotenv")
Dotenv.load ".env.local", ".env.#{Rails.env}"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Remoteruby
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Use SQL format DDL instead of the Ruby DSL
    config.active_record.schema_format = :sql

    # Clean/DDD style layered architecture
    # ---
    # The whole point of layers is to explicitly control
    # the direction of dependencies. The flow of dependencies
    # can only go from an outer layer to the one just beneath it.
    # So for example, things in the application layer can depend
    # on things in the domain layer, but the domain layer can't
    # have knowledge of anything in the application layer.

    ####################
    # Domain Layer
    ####################
    # Domain entities. Note that top-level entities are aggregates
    config.autoload_paths << Rails.root.join("app/domain_layer/entities")
    config.autoload_paths << Rails.root.join("app/domain_layer/services")

    ####################
    # Application Layer
    ####################
    # A single point of interaction with the application layer
    # Could be split into commands and queries in a future refactor
    config.autoload_paths << Rails.root.join("app/application_layer/queries")
    config.autoload_paths << Rails.root.join("app/application_layer/commands")
    config.autoload_paths << Rails.root.join("app/application_layer/result_entities")
    # Any ancillary logic that isn't part of a use case itself
    # We aren't using this yet but it's commonly referenced in the literature
    config.autoload_paths << Rails.root.join("app/application_layer/services")

    ####################
    # Infrastructure Layer
    ####################
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/controllers")
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/entity_builders")
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/mailers")
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/jobs")
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/records")
    config.autoload_paths << Rails.root.join("app/infrastructure_layer/repositories")

    ####################
    # User Interface Layer
    ####################
    config.autoload_paths << Rails.root.join("app/user_interface_layer/templates")
    config.autoload_paths << Rails.root.join("app/user_interface_layer/view_models")
    config.autoload_paths << Rails.root.join("app/user_interface_layer/services")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
