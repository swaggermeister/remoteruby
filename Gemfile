# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.2", ">= 6.0.2.2"
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
# use postgres
gem "pg"
gem "pg_search"
# Use Puma as the app server
gem "puma", ">= 4.1", "< 4.3.9"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker", "~> 5.0"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.7"

# Cache store
gem "redis", "~> 4.5"

gem "binding_of_caller", "~> 0.8.0"
gem "redcarpet", "~> 3.5.0"
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'

# Use Devise for authentication
gem "devise", "~>4.8.0"

# Pagy for pagination
gem "pagy"

# OAuth gems
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"

# Use Active Storage variant
gem "image_processing", "~> 1.2"

# AWS for avatar image storage
gem "aws-sdk-s3", require: false

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", "1.8.1", require: false

# Linter for PG migrations
gem "strong_migrations"

gem "dotenv-rails"

# Monitoring for production
gem "newrelic_rpm"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "brakeman", require: false
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  # gem "listen", ">= 3.0.5", "< 3.2"
  gem "listen", ">= 3.3.0"
  gem "web-console", ">= 3.3.0"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "better_errors"
  gem "rubocop", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"

  # gem "binding_of_caller"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "mocha"
  gem "selenium-webdriver"
  # Easy installation and use of web drivers to run system tests with browsers
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
