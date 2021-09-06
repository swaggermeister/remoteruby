# frozen_string_literal: true

module Employers
  class ShowPresenter
    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end

    # public
  end
end
