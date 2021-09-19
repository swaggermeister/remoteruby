# frozen_string_literal: true

module Employers
  class ShowPresenter
    delegate :avatar, to: :employer

    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end
  end
end
