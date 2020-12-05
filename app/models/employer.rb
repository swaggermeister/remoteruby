class Employer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_confirmation_of :password
  validates_presence_of :password_confirmation, if: ->(employer) { employer.password.present? }
  has_many :job_listings, dependent: :destroy
  has_secure_password
end
