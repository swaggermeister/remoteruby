# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# seed employers
employer_names = [
  "DeskCorp",
  "AutoLab",
  "HRForce",
  "Google",
  "Smith & Smith"
]

employer_emails = [
  "jbob@deskcorp.com",
  "cjones@autolab.com",
  "mdavis@hrforce.com",
  "agail@google.com",
  "bsmith@smithsmith.com"
]

employer_passwords = [
  "test1234",
  "pass7890",
  "dogs1267",
  "cats2345",
  "bananas5678"
]

100.times.map do |n|
  random = Random.new

  Employer.create(name: employer_names[random.rand(employer_names.length)],
                  email: employer_emails[random.rand(employer_emails.length)],
                  password: employer_passwords[random.rand(employer_passwords.length)])
end

# seed job listings
job_titles = [
  "Senior Ruby on Rails Engineer",
  "Full Stack Rails Engineer",
  "Rails Backend Specialist",
  "Rails Developer with React experience",
  "Rails API Scalability Expert",
  "Ruby Developer with 20 Years Experience"
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
  "Toronto"
]

job_salaries = [
  "20000",
  "200k",
  "15k plus equity",
  "97$/hr",
  "120000"
]

100.times.map do |n|
  random = Random.new

  JobListing.create(title: job_titles[random.rand(job_titles.length)],
                    description: job_description,
                    location: job_locations[random.rand(job_locations.length)],
                    salary: job_salaries[random.rand(job_salaries.length)],
                    employer_name: employer_names[random.rand(employer_names.length)])
end
