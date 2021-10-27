# frozen_string_literal: true

module AvatarUrlBuilder
  def self.build(employer:)
    if employer.avatar.attached?
      employer.avatar
    else
      hash = Digest::MD5.hexdigest(employer.email.downcase)
      "https://secure.gravatar.com/avatar/#{hash}.png?s=96"
    end
  end
end
