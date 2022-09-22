# frozen_string_literal: true

require "securerandom"

employer_names = [
  "DeskCorp",
  "AutoLab",
  "HRForce",
  "TestCo",
  "Smith & Smith"
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
  "Ruby Developer with 20 Years Experience"
]

job_description = <<~JOBDESC
  <h3>History, Purpose and Usage</h3>
  <p><em>Lorem ipsum</em>, or <em>lipsum</em> as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's <em>De Finibus Bonorum et Malorum</em> for use in a type specimen book. It usually begins with:
  </p>
  <blockquote>“Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.”</blockquote>
  <p>The purpose of <em>lorem ipsum</em> is to create a natural looking block of text (sentence, paragraph, page, etc.) that doesn't distract from the layout. A practice not without <a href="#" title="Controversy in the Design World">controversy</a>, laying out pages with meaningless filler text can be very useful when the focus is meant to be on design, not content.
  </p>
  <p>The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our <a href="#" title="Lorem Ipsum Generator">generator</a> to get your own, or read on for the authoritative history of <em>lorem ipsum</em>.
  </p>

JOBDESC

job_locations = [
  "Demotown",
  "Boston, MA",
  "NYC",
  "Philly",
  "Toronto"
]

job_hourly_fixed_compensation_types = [
  "Negotiable",
  "15/hr plus equity",
  "$97/hr"
]

job_minimum_salaries = [
  80_000,
  100_000,
  120_000,
  50_000
]

job_maximum_salaries = [
  75_000,
  100_000,
  130_000,
  200_000
]

desc "custom task to seed the db with test employer/job listing data"
task seed: :environment do
  Rake::Task["seed_employers"].invoke
  Rake::Task["seed_job_listings"].invoke
end

desc "custom task to seed the db with test employers"
task seed_employers: :environment do
  Array.new(5) do
    pw = employer_passwords.sample
    EmployerRecord.create!(name: employer_names.sample,
                           email: "#{SecureRandom.hex}@test.com",
                           password: pw,
                           password_confirmation: pw,
                           confirmed_at: Time.zone.now)
  end
end

desc "custom task to seed the db with test job listings"
task seed_job_listings: :environment do
  employers = EmployerRecord.select(:id).limit(10)

  Array.new(10) do
    JobListingRecord.create!(title: job_titles.sample,
                             description: job_description,
                             location: job_locations.sample,
                             fixed_amount: job_hourly_fixed_compensation_types.sample,
                             contact_email: "#{SecureRandom.hex}@demo.com",
                             employer_id: employers.sample.id)
  end

  Array.new(10) do
    min_salary = job_minimum_salaries.sample
    max_salary = job_maximum_salaries.select { |salary| salary > min_salary }.sample
    JobListingRecord.create!(title: job_titles.sample,
                             description: job_description,
                             location: job_locations.sample,
                             minimum_salary: min_salary,
                             maximum_salary: max_salary,
                             contact_url: "http://#{SecureRandom.hex}.com",
                             employer_id: employers.sample.id)
  end
end
