# frozen_string_literal: true

module ApplicationHelper
  def presenter
    @presenter || begin
      throw "No @presenter was set!"
    end
  end
end
