# frozen_string_literal: true

module Employers
  class ConfirmationsController < Devise::ConfirmationsController
    def new
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def create
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    def show
      prepare_view!(::DefaultDeviseViewModel)
      super
    end

    # protected

    # The path used after resending confirmation instructions.
    # def after_resending_confirmation_instructions_path_for(resource_name)
    #   super(resource_name)
    # end

    # The path used after confirmation.
    # def after_confirmation_path_for(resource_name, resource)
    #   super(resource_name, resource)
    # end
  end
end
