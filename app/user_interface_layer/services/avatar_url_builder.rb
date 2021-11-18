# frozen_string_literal: true

module AvatarUrlBuilder
  def self.build(employer:)
    if employer&.avatar.respond_to?(:attachment) && employer&.avatar&.attachment
      return employer.avatar
    end

    hash = Digest::MD5.hexdigest(employer.email.downcase)
    "https://secure.gravatar.com/avatar/#{hash}.png?s=96"
  end
end
