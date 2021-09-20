# frozen_string_literal: true

module UrlFormatValidator
  def self.valid?(url:)
    url.starts_with?("http://") || url.starts_with?("https://")
  end
end
