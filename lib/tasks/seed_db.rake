# frozen_string_literal: true

require "securerandom"

employer_names = [
  "DeskCorp",
  "AutoLab",
  "HRForce",
  "Google",
  "Smith & Smith",
]

employer_passwords = %w[
  test1234
  pass7890
  dogs1267
  cats2345
  bananas5678
]

job_titles = [
  "Senior Ruby on Rails Engineer",
  "Full Stack Rails Engineer",
  "Rails Backend Specialist",
  "Rails Developer with React experience",
  "Rails API Scalability Expert",
  "Ruby Developer with 20 Years Experience",
]

job_description = <<~JOBDESC
  ### About the Role

  Tithe.ly is currently looking to recruit a full-time Ruby on Rails Developer to join a team focused on writing code that will allow our Products to integrate with different 3rd party systems.

  This position affords the opportunity to collaborate with other experienced engineers while also providing plenty of space for autonomy and coding. You will need to be able to think on your feet, be innovative and be independent when required.

  This is an awesome opportunity to get involved with a growing company that practices continuous development and building something great!

  100% remote opportunity, but must be based in the US or Canada.

  ### Duties & Responsibilities

  The successful candidate will find themselves working with Ruby on Rails, contributing heavily to our web-based software. The candidate will also have the chance to grow their skillset under a highly skilled team that can guide the candidate and unlock their full potential.

  ### Key skillsets

  **Technology**

  - 2+ years experience in Ruby/Rails
  - Extensive experience in writing unit and integration tests
  - Solid understanding of RESTful APIs
  - Experience with using non-trivial APIs to read and save data
  - Solid understanding of JavaScript, CSS, HTML
  - Solid understanding of Git
  - Experience with writing SQL queries and using MySQL/PostgreSQL
  - Experience working with Docker
  - Comfortable working in a Unix/Linux environment

  **Human / Relational:**

  - Find joy in working out solutions to tricky problems
  - Willingness to learn and expand upon existing skill sets
  - A team player & able to work without supervision
  - Quick learner & takes initiative
  - Possess a high level of attention to detail
  - Ability to effectively communicate technical information into simple terms
  - Have a friendly, patient & positive nature
  - Thinks Real Genius is a great movie

  ### Benefits & Culture

  You will be joining a very friendly and social team, who are highly skilled technically, where you will be working with the latest technology. This is a 100% remote opportunity, but must be based in the US or Canada.

  Salary will depend on the level of experience.

  ### Applying for the Role

  All applicants require a cover letter in the "Note" field for us to consider your application.

  Please start your cover letter with "I love code!" so we can ensure you've read the ad.

  **Job Type:** Full-time

  **Salary:** $80,000.00 to $140,000.00 /year

  **Experience:** Ruby on Rails: 2 years (Required)

  **Work Location:** Fully Remote

  **Schedule:** Monday to Friday

  **Company's website:** https://get.tithe.ly

  **Work Remotely:** Yes

JOBDESC

job_locations = [
  "Littleton",
  "Boston, MA",
  "NYC",
  "Philly",
  "Toronto",
]

job_hourly_fixed_compensation_types = [
  "200 breads",
  "15/hr plus equity",
  "97$/hr",
]

job_minimum_salaries = [
  80000,
  100000,
  120000,
  50000,
]

job_maximum_salaries = [
  75000,
  100000,
  130000,
  200000,
]

desc "custom task to seed the db with test employer/job listing data"
task seed: :environment do
  Rake::Task["seed_employers"].invoke
  Rake::Task["seed_job_listings"].invoke
end

desc "custom task to seed the db with test employers"
task seed_employers: :environment do
  Array.new(100) do
    pw = employer_passwords.sample
    Employer.create!(name: employer_names.sample,
                     email: "#{SecureRandom.hex}@test.com",
                     password: pw,
                     password_confirmation: pw)
  end
end

desc "custom task to seed the db with test job listings"
task seed_job_listings: :environment do
  employers = Employer.select(:id, :name).limit(100)

  Array.new(50) do
    JobListing.create!(title: job_titles.sample,
                       description: job_description,
                       location: job_locations.sample,
                       salary: job_hourly_fixed_compensation_types.sample,
                       contact_email: "#{SecureRandom.hex}@test.com",
                       employer_name: employers.sample.name,
                       employer_id: employers.sample.id)
  end

  Array.new(50) do
    min_salary = job_minimum_salaries.sample
    max_salary = job_maximum_salaries.select { |salary| salary > min_salary }.sample
    JobListing.create!(title: job_titles.sample,
                       description: job_description,
                       location: job_locations.sample,
                       minimum_salary: min_salary,
                       maximum_salary: max_salary,
                       contact_url: "http://#{SecureRandom.hex}.com",
                       employer_name: employers.sample.name,
                       employer_id: employers.sample.id)
  end
end
