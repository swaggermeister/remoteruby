class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_employer!
  # before_action :authorize

  def home
  end

  protected

  def authorize
    unless current_employer
      redirect_to login_url, alert: "Please log in"
    end
  end

  def current_employer
    @current_employer ||= Employer.find_by(id: session[:employer_id])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
