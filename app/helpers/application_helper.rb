# frozen_string_literal: true

module ApplicationHelper
  # rubocop:disable Rails/HelperInstanceVariable
  def presenter
    @presenter || begin
      throw 'No @presenter was set!'
    end
  end

  # rubocop:enable Rails/HelperInstanceVariable
end
