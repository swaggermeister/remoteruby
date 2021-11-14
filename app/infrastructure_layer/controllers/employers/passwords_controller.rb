# frozen_string_literal: true

module Employers
  class PasswordsController < Devise::PasswordsController
    # GET /resource/password/new
    def new
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # POST /resource/password
    def create
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # GET /resource/password/edit?reset_password_token=abcdef
    def edit
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # PUT /resource/password
    def update
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # protected

    # def after_resetting_password_path_for(resource)
    #   super(resource)
    # end

    # The path used after sending reset password instructions
    # def after_sending_reset_password_instructions_path_for(resource_name)
    #   super(resource_name)
    # end
  end
end
