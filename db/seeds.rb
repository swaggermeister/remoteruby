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

100.times.map do |n|
  random = Random.new

  JobListing.create(title: job_titles[random.rand(job_titles.length)],
                    description: "Work very hard for us all day please thanks",
                    location: "Littleton",
                    salary: "20000")
end
