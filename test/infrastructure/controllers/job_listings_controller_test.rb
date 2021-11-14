# frozen_string_literal: true

require "test_helper"

class JobListingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get job_listings_url
    assert_response :success
  end

  test "should get new" do
    employer_record = create_employer_record!
    sign_in employer_record

    get new_job_listing_url
    assert_response :success
  end

  test "should create job_listing" do
    employer_record = create_employer_record!
    sign_in employer_record

    assert_difference("JobListingRecord.count") do
      post job_listings_url,
           params: { job_listing: { description: "A test job description", location: "Washington DC", fixed_amount: "150000",
                                    title: "Senior Architect", contact_url: "http://bread.com" } }
    end

    assert_redirected_to my_company_job_listings_path
  end

  test "should show job_listing" do
    employer_record = create_employer_record!
    job_listing_record = create_job_listing_record!(employer_record: employer_record)
    job_listing = to_result_entity(job_listing_record)

    get job_listing_url(job_listing)
    assert_response :success
  end

  test "should get edit" do
    employer_record = create_employer_record!
    job_listing_record = create_job_listing_record!(employer_record: employer_record)
    job_listing = to_result_entity(job_listing_record)

    sign_in employer_record
    get edit_job_listing_url(job_listing)
    assert_response :success
  end

  test "should update job_listing" do
    employer_record = create_employer_record!
    job_listing_record = create_job_listing_record!(employer_record: employer_record)
    job_listing = to_result_entity(job_listing_record)

    sign_in employer_record
    patch job_listing_url(job_listing),
          params: { job_listing: { description: job_listing.description,
                                   location: job_listing.location,
                                   fixed_amount: job_listing.fixed_amount,
                                   title: job_listing.title } }
    assert_redirected_to my_company_job_listings_path
  end

  test "should destroy job_listing" do
    employer_record = create_employer_record!
    job_listing_record = create_job_listing_record!(employer_record: employer_record)
    job_listing = to_result_entity(job_listing_record)

    sign_in employer_record
    assert_difference("JobListingRecord.count", -1) do
      delete job_listing_url(job_listing)
    end

    assert_redirected_to my_company_job_listings_path
  end
end
