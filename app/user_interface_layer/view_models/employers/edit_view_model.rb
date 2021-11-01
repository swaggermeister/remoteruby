# frozen_string_literal: true

module Employers
  class EditViewModel
    include Shared::WebShared
    include Shared::FormShared

    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end
  end
end
