# frozen_string_literal: true

require "test_helper"

class JobListingsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get index" do
    get job_listings_url
    assert_response :success
  end

  test "should get new" do
    employer = create_employer!
    sign_in employer

    get new_job_listing_url
    assert_response :success
  end

  test "should create job_listing" do
    employer = create_employer!
    sign_in employer

    assert_difference("JobListing.count") do
      post job_listings_url,
           params: { job_listing: { description: "A test job description", location: "Washington DC", fixed_amount: "150000",
                                    title: "Senior Architect", contact_url: "http://bread.com" } }
    end

    assert_redirected_to my_company_job_listings_path
  end

  test "should show job_listing" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer)

    get job_listing_url(job_listing)
    assert_response :success
  end

  test "should get edit" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer)

    sign_in employer
    get edit_job_listing_url(job_listing)
    assert_response :success
  end

  test "should update job_listing" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer)

    sign_in employer
    patch job_listing_url(job_listing),
          params: { job_listing: { description: job_listing.description,
                                   location: job_listing.location,
                                   fixed_amount: job_listing.fixed_amount,
                                   title: job_listing.title } }
    assert_redirected_to my_company_job_listings_path
  end

  test "should destroy job_listing" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer)

    sign_in employer
    assert_difference("JobListing.count", -1) do
      delete job_listing_url(job_listing)
    end

    assert_redirected_to my_company_job_listings_path
  end
end
