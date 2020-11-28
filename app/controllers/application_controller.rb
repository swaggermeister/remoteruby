class ApplicationController < ActionController::Base
  before_action :authorize

  def home
  end

  protected

  def authorize
    unless current_user
      redirect_to login_url, alert: "Please log in"
    end
  end

  def current_user
    @current_user ||= Employer.find_by(id: session[:employer_id])
  end
end
