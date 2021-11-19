# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_employer!

  # Use a custom path for template files
  # instead of Rails default of app/views
  # NOTE: this must be prepend instead of append,
  # otherwise Devise will not find the custom Devise views
  prepend_view_path "app/user_interface_layer/templates"

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
    @view || prepare_view!(DefaultWebViewModel)
  end

  # Build the view model for templates to use
  def prepare_view!(view_model_module, **args)
    # Ideally, in our architecture the controller should never
    # be seeing database records (ActiveRecord) because it should
    # only be talking to the application layer and getting back
    # result entities from those use cases. However, Devise forces
    # us to work directly with ActiveRecord. So we have to convert
    # the ActiveRecord employer -> use cases result entity to
    # patch over the tight coupling of Devise
    result_employer = if current_employer
        # We have to go through this chain because
        # typically result entities are only made from domain entities
        # but here we are stuck with the AR record
        # rubocop:disable Layout/FirstArgumentIndentation
        employer_entity = Employer.new(**current_employer.attributes.merge(
                                         # attach the avatar as well, since it's not an
                                         # attribute from the DB record, but actually
                                         # built from the avatar method on the AR record
                                         avatar: current_employer.avatar,
                                       ))
        # rubocop:enable Layout/FirstArgumentIndentation
        ResultEmployer.from_entity(employer_entity)
      end

    # Build the view model
    view_model = view_model_module.new(**args.merge(current_employer: result_employer))

    # Set it to an ivar for the templates to have access to
    @view = view_model
  end
end
