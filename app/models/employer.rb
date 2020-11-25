class Employer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates_confirmation_of :password
  has_many :job_listings, dependent: :destroy
  has_secure_password
end
