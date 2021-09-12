# frozen_string_literal: true

class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable,
         :omniauthable, omniauth_providers: %i[Google]

  # Validation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Associations
  has_many :job_listings, dependent: :destroy

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
