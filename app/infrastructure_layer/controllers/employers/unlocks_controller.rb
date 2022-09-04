# frozen_string_literal: true

module Employers
  class UnlocksController < Devise::UnlocksController
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

    # The path used after sending unlock password instructions
    # def after_sending_unlock_instructions_path_for(resource)
    #   super(resource)
    # end

    # The path used after unlocking the resource
    # def after_unlock_path_for(resource)
    #   super(resource)
    # end
  end
end
