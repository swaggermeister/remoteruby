# frozen_string_literal: true

module Employers
  class EditView
    include Shared::WebShared
    include Shared::FormShared

    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end
  end
end
