# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "mocha/minitest" # mocks and stubs

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def login_employer(employer)
      ApplicationController.any_instance.stubs(:current_employer).returns(employer)
    end

    def create_employer_record!(name: nil, email: nil, password: nil, avatar: nil, is_confirmed: true, is_locked: false)
      name ||= "Test #{random_string}"
      email ||= "#{random_string}@test.com"
      password ||= random_string
      avatar ||= Rack::Test::UploadedFile.new(file_fixture("bread.jpg"), "image/jpg")
      confirmed_at = Time.zone.now if is_confirmed
      locked_at = Time.zone.now if is_locked

      employer = EmployerRecord.create!(
        name: name,
        email: email,
        password: password,
        avatar: avatar,
        confirmed_at: confirmed_at,
        locked_at: locked_at,
      )
      employer.avatar.attach(avatar)
      employer.save!

      employer
    end

    def mock_google_auth_hash
      OmniAuth.config.mock_auth[:Google] = OmniAuth::AuthHash.new({
                                                                    provider: "Google",
                                                                    uid: "123545",
                                                                    info: {
                                                                      name: "mockuser",
                                                                      email: "mock_user@mock.com",
                                                                    },
                                                                    credentials: {
                                                                      token: "token",
                                                                      refresh_token: "another_token",
                                                                      expires_at: 1_354_920_555,
                                                                      expires: true,
                                                                    },
                                                                  })
    end

    def create_job_listing!(...)
      # build the record
      job_listing_record = build_job_listing_record(...)

      # convert it to an entity
      job_listing = JobListingEntityBuilder.to_entity(record: job_listing_record)

      # create in DB and get back the entity again, this time
      # populated with validation errors if there are any
      job_listing = JobListingsCommandRepository.create!(entity: job_listing)

      # convert the domain entity to a result entity
      ResultJobListing.from_entity(job_listing)
    end

    def build_job_listing_record(employer_record:,
                                 title: nil,
                                 description: nil,
                                 location: nil,
                                 fixed_amount: nil,
                                 minimum_salary: nil,
                                 maximum_salary: nil,
                                 contact_email: nil,
                                 contact_url: nil)
      title ||= "A Great Job #{random_string}"
      description ||= "The best job you will ever have you will love it #{random_string}"
      location ||= "Randomville, CA"
      contact_url ||= contact_email.nil? ? "http://test.com" : nil
      fixed_amount ||= "99 breads" if minimum_salary.blank? || maximum_salary.blank?

      JobListingRecord.new(
        title: title,
        description: description,
        location: location,
        fixed_amount: fixed_amount,
        minimum_salary: minimum_salary,
        maximum_salary: maximum_salary,
        employer: employer_record,
        contact_email: contact_email,
        contact_url: contact_url,
      )
    end

    def to_result_entity(record:)
      case record
      when EmployerRecord
        entity = EmployerEntityBuilder.to_entity(record: record)
        ResultEmployer.from_entity(entity)
      when JobListingRecord
        entity = JobListingEntityBuilder.to_entity(record: record)
        ResultJobListing.from_entity(entity)
      else
        raise "Can't convert record: #{record.class} to a result entity. Are you sure it's a record class?"
      end
    end

    def random_string
      SecureRandom.hex.split("-").join
    end

    def enable_omniauth_test_mode
      OmniAuth.config.test_mode = true
    end
  end
end
