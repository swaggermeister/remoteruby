class Employer < ApplicationRecord
  has_many :job_listings, dependent: :destroy
end
