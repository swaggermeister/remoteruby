# frozen_string_literal: true

module Employers
  class PasswordsController < Devise::PasswordsController
    # GET /resource/password/new
    def new
      @view = ::DefaultDeviseView.new
      super
    end

    # POST /resource/password
    def create
      @view = ::DefaultDeviseView.new
      super
    end

    # GET /resource/password/edit?reset_password_token=abcdef
    def edit
      @view = ::DefaultDeviseView.new
      super
    end

    # PUT /resource/password
    def update
      @view = ::DefaultDeviseView.new
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
