# frozen_string_literal: true

module Devise
  class MailerPreview < ActionMailer::Preview
    # hit http://localhost:3000/rails/mailers/devise/mailer/confirmation_instructions
    def confirmation_instructions
      Devise::Mailer.confirmation_instructions(EmployerRecord.first, {})
    end

    # hit http://localhost:3000/rails/mailers/devise/mailer/reset_password_instructions
    def reset_password_instructions
      Devise::Mailer.reset_password_instructions(EmployerRecord.first, {})
    end

    # hit http://localhost:3000/rails/mailers/devise/mailer/unlock_instructions
    def unlock_instructions
      Devise::Mailer.unlock_instructions(EmployerRecord.first, {})
    end
  end
end
