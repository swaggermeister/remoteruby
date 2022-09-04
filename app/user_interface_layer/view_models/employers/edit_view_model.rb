# frozen_string_literal: true

module Employers
  class EditViewModel
    include Shared::WebShared
    include Shared::FormShared

    attr_reader :employer

    private

    def initialize(current_employer:, employer:)
      @current_employer = current_employer
      @employer = employer
    end
  end
end
