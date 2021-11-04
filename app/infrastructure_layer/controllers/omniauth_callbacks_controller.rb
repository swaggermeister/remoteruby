# frozen_string_literal: true

class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # rubocop:disable Naming/MethodName
  def Google
    # You need to implement the method below in your model (e.g. app/models/user.rb)
    @employer = EmployerRecord.from_omniauth(request.env["omniauth.auth"].except(:extra))

    if @employer.persisted?
      sign_in_and_redirect @employer # , event: :authentication # this will throw if @employer is not activated
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      google_auth_fields = %w[email name password]
      session["devise.google_data"] = request.env["omniauth.auth"].except(:extra).select { |k, _v| google_auth_fields.include?(k) } # Removing extra as it can overflow some session stores
      redirect_to new_employer_registration_url, alert: @employer.errors.full_messages.join("\n")
    end
  end

  # rubocop:enable Naming/MethodName
end
