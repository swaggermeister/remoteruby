# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_employer!

  # Use a custom path for template files
  # instead of Rails default of app/views
  # NOTE: this must be prepend instead of append,
  # otherwise Devise will not find the custom Devise views
  prepend_view_path "app/presentation/templates"

  def home; end

  private

  def configure_permitted_parameters
    update_attrs = %i[password password_confirmation current_password avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def after_sign_in_path_for(_resource)
    my_company_job_listings_path
  end

  # Make the view.method available in all views
  helper_method :view

  def view
    # If a view was already set in the action, use that.
    # Otherwise fall back to a default web view
    @view || DefaultWebView.new
  end
end
