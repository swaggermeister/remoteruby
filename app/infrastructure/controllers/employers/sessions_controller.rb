# frozen_string_literal: true

module Employers
  class SessionsController < Devise::SessionsController
    # before_action :configure_sign_in_params, only: [:create]

    # GET /resource/sign_in
    def new
      @view = ::DefaultDeviseView.new
      super
    end

    # POST /resource/sign_in
    def create
      @view = ::DefaultDeviseView.new
      super
    end

    # DELETE /resource/sign_out
    def destroy
      @view = ::DefaultDeviseView.new
      super
    end

    # protected

    # If you have extra params to permit, append them to the sanitizer.
    # def configure_sign_in_params
    #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    # end
  end
end
