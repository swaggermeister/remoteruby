# frozen_string_literal: true

module Employers
  class EditPresenter
    # delegate :avatar, to: :employer

    attr_reader :employer

    private

    def initialize(employer:)
      @employer = employer
    end

    # public

    # def avatar_url
    #   if employer.avatar.attached?
    #     employer.avatar
    #   else
    #     hash = Digest::MD5.hexdigest(employer.email.downcase)
    #     "https://secure.gravatar.com/avatar/#{hash}.png?s=32"
    #   end
    # end
  end
end
