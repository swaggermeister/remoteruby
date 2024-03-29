# frozen_string_literal: true

module Employers
  class ShowViewModel
    include Shared::WebShared

    delegate :avatar, to: :employer

    attr_reader :employer

    private

    def initialize(current_employer:, employer:)
      @current_employer = current_employer
      @employer = employer
    end
  end
end
