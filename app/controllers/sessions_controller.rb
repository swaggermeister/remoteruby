class SessionsController < ApplicationController
  def new
  end

  def create
    employer = Employer.find_by(email: params[:email])
    if employer&.authenticate(params[:password])
      session[:employer_id] = employer.employer_id
      redirect_to my_company_job_listings_path
    else
      redirect_to sessions_new_path, alert: "Invalid user/password combination"
    end
  end

  def destroy
  end
end
