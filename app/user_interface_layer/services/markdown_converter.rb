# frozen_string_literal: true

module MarkdownConverter
  class << self
    def markdown(text)
      output = redcarpet.render(text)
      sanitize(output)
    end

    def sanitize(html)
      # rubocop:disable Rails/OutputSafety
      Rails::Html::SafeListSanitizer.new.sanitize(html).html_safe
      # rubocop:enable Rails/OutputSafety
    end

    private

    def redcarpet
      @redcarpet ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, {})
    end
  end
end
