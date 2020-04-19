# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

job_titles = [
  "Senior Ruby on Rails Engineer",
  "Full Stack Rails Engineer",
  "Rails Backend Specialist",
  "Rails Developer with React experience",
  "Rails API Scalability Expert",
  "Ruby Developer with 20 Years Experience"
]

job_descriptions = [
  "Write both back-end and front-end application code to build out our site, add features and functionality, debug, and oversee all new development.",
  "Write code, as well as modifying software to fix errors, adapt it to new hardware, improve its performance, or upgrade interfaces.",
  "Work closely with our small and passionate in-house product development team who focus in different areas including: product design, data science, bio-sensing, IoT and audio systems. The Backend Developer role involves taking features from conceptualisation and prototyping through to production and maintenance, it will ideally suit someone with broad production experience using Ruby on Rails/ Dockers/ PostgreSQL and Python. Ruby/Rails will be the most important area of experience for this role. We expect the candidate to be able to bring their expertise for designing for maintainability, reliability and scalability to the fore. The role suits a candidate who has excellent existing backend technology knowledge but also maintains a thirst for expanding their expertise, can concisely communicate their ideas to cross-functional team members and can balance their workload to effectively meet the needs of the business.",
  "productboard's stack is a Ruby on Rails backend built by passionate Rubyists with React.js on Typescript on the frontend. Over time with demand, we've added new technologies to support the growing needs of the team, both in complexity and traffic. We're running Elasticsearch to power our Insights search, we are fully migrated to Kubernetes on AWS to enable an event-driven service architecture, we're using Kafka to let services communicate together asynchronously and resiliently.",
  <<-JOBDESC
  We are looking for a full-time, full stack engineer with strong Rails and Javascript experience to join our team of talented coders and content creators.

  About the Role

  We’re looking for a hungry, talented engineer who wants to make a big impact at this early stage in our roadmap.

  As a full stack engineer,  you will be responsible for building out the intuitive, interactive experiences that our customers need to organize their own documentation, as well as determining the backend architecture and endpoints that we need to support those features.
  JOBDESC

]

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

employers = [
  "DeskCorp",
  "AutoLab",
  "HRForce",
  "Google",
  "Smith & Smith"
]

100.times.map do |n|
  random = Random.new

  JobListing.create(title: job_titles[random.rand(job_titles.length)],
                    description: job_descriptions[random.rand(job_descriptions.length)],
                    location: job_locations[random.rand(job_locations.length)],
                    salary: job_salaries[random.rand(job_salaries.length)],
                    employer_name: employers[random.rand(employers.length)])
end
