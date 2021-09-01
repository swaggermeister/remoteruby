ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest" #mocks and stubs

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
  def login_employer(employer)
    ApplicationController.any_instance.stubs(:current_employer).returns(employer)
  end

  def create_employer!(name: nil, email: nil, password: nil)
    puts "name: #{name}"
    puts "email: #{email}"

    name ||= "Test #{random_string}"
    email ||= "#{random_string}@test.com"
    # password ||= random_string

    Employer.create!(
      name: name,
      email: email,
      # password: password,
      # password_confirmation: password,
    )
  end

  def create_job_listing!(employer:, title: nil, description: nil, location: nil, salary: nil)
    title ||= "A Great Job #{random_string}"
    description ||= "The best job you will ever have you will love it #{random_string}"
    location ||= "Randomville, CA"
    salary ||= "99,500"

    JobListing.create!(
      title: title,
      description: description,
      location: location,
      salary: salary,
      employer: employer,
    )
  end

  def random_string
    SecureRandom.hex.split("-").join
  end
end
