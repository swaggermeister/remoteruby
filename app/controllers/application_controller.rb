# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_employer!

  def home; end

  protected

  def configure_permitted_parameters
    update_attrs = %i[password password_confirmation current_password avatar]
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def after_sign_in_path_for(_resource)
    my_company_job_listings_path
  end
end
