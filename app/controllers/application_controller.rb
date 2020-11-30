class ApplicationController < ActionController::Base
  before_action :authorize

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
end
