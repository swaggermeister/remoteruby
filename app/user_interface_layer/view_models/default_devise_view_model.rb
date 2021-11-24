# frozen_string_literal: true

class DefaultDeviseViewModel
  include Shared::WebShared
  include Shared::FormShared

  def initialize(current_employer:)
    @current_employer = current_employer
  end
end
