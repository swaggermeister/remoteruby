module Employers
  class EditPresenter
    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end

    # public
  end
end