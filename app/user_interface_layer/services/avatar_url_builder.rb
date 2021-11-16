# frozen_string_literal: true

module AvatarUrlBuilder
  def self.build(employer:)
    return employer.avatar if employer&.avatar&.attachment

    hash = Digest::MD5.hexdigest(employer.email.downcase)
    "https://secure.gravatar.com/avatar/#{hash}.png?s=96"
  end
end
