# frozen_string_literal: true

module Employers
  class UnlocksController < Devise::UnlocksController
    # GET /resource/unlock/new
    def new
      @view = ::DefaultDeviseViewModel.new
      super
    end

    # POST /resource/unlock
    def create
      @view = ::DefaultDeviseViewModel.new
      super
    end

    # GET /resource/unlock?unlock_token=abcdef
    def show
      @view = ::DefaultDeviseViewModel.new
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