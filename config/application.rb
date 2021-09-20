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

    # DDD layered architecture
    # Domain Layer
    config.autoload_paths << Rails.root.join("app/domain/models")
    config.autoload_paths << Rails.root.join("app/domain/services")
    # Application Layer
    config.autoload_paths << Rails.root.join("app/application/jobs")
    config.autoload_paths << Rails.root.join("app/application/services")
    config.autoload_paths << Rails.root.join("app/application/use_cases")
    # Infrastructure Layer
    config.autoload_paths << Rails.root.join("app/infrastructure/controllers")
    config.autoload_paths << Rails.root.join("app/infrastructure/mailers")
    # Presentation Layer
    # TODO: remove helpers dir and move the logic into "views"
    config.autoload_paths << Rails.root.join("app/presentation/helpers")
    config.autoload_paths << Rails.root.join("app/presentation/templates")
    config.autoload_paths << Rails.root.join("app/presentation/views")
    config.autoload_paths << Rails.root.join("app/presentation/services")

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
