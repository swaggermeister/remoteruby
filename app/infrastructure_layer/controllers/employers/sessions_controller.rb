# frozen_string_literal: true

module Employers
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    def new
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def create
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def destroy
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
