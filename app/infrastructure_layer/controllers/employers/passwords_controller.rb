# frozen_string_literal: true

module Employers
  class PasswordsController < Devise::PasswordsController
    def new
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def create
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def edit
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

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
