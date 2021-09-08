# frozen_string_literal: true

module MarkdownConverter
  class << self
    def markdown(text)
      # rubocop:disable Rails/OutputSafety
      redcarpet.render(text).html_safe
      # rubocop:enable Rails/OutputSafety
    end

    private

    def redcarpet
      @redcarpet ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {})
    end
  end
end
