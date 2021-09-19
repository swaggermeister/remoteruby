# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  # rubocop:disable Rails/HelperInstanceVariable
  def presenter
    @presenter || begin
      throw "No @presenter was set!"
    end
  end

  # rubocop:enable Rails/HelperInstanceVariable

  def avatar_url(employer)
    if employer.avatar.attached?
      employer.avatar
    else
      hash = Digest::MD5.hexdigest(employer.email.downcase)
      "https://secure.gravatar.com/avatar/#{hash}.png?s=32"
    end
  end
end
