class Employer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable

  # Validation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  # Associations
  has_many :job_listings, dependent: :destroy
end
