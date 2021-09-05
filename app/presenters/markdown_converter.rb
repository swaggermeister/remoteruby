# frozen_string_literal: true

module MarkdownConverter
  class << self
    def markdown(text)
      redcarpet.render(text).html_safe
    end

    private

    def redcarpet
      @redcarpet ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {})
    end
  end
end
