# frozen_string_literal: true

class EmployerRecord < ApplicationRecord
  self.table_name = "employers"

  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: %i[Google]

  # Associations
  # TODO: remove this association? It doesn't have to go both ways
  has_many :job_listings, class_name: "JobListingRecord", dependent: :destroy, foreign_key: :employer_id
  has_one_attached :avatar

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |employer|
      employer.email = auth.info.email
      employer.password = Devise.friendly_token[0, 20]
      employer.name = auth.info.name # assuming the employer model has a name
      # employer.image = auth.info.image # assuming the employer model has an image
      # If you are using confirmable and the provider(s) you use validate emails,
      # uncomment the line below to skip the confirmation emails.
      employer.skip_confirmation!
    end
  end
end
