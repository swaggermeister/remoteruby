# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  # Add custom search paths for mailer templates
  # for a Clean architecture style naming convention
  prepend_view_path Rails.root.join("app/presentation/templates")

  default from: "help@remoterubyonrails.com"
  layout "mailer"
end
