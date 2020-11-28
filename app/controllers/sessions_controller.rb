class SessionsController < ApplicationController
  skip_before_action :authorize

  def new
  end

  def create
    employer = Employer.find_by(email: params[:email])

    if employer&.authenticate(params[:password])
      session[:employer_id] = employer.id
      redirect_to my_company_job_listings_path, notice: "Successfully logged in!"
    else
      redirect_to login_path, alert: "Invalid user/password combination"
    end
  end

  def destroy
    session[:employer_id] = nil
    redirect_to job_listings_url, notice: "Logged out"
  end
end
