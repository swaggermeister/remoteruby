require "test_helper"

class JobListingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get job_listings_url
    assert_response :success
  end

  test "should get new" do
    employer = employers(:two)
    login_employer(employer)

    get new_job_listing_url
    assert_response :success
  end

  test "should create job_listing" do
    employer = employers(:two)
    login_employer(employer)

    assert_difference("JobListing.count") do
      post job_listings_url, params: { job_listing: { description: "A test job description", location: "Washington DC", salary: "150000", title: "Senior Architect" } }
    end

    assert_redirected_to my_company_job_listings_path
  end

  test "should show job_listing" do
    job_listing = job_listings(:one)

    get job_listing_url(job_listing)
    assert_response :success
  end

  test "should get edit" do
    employer = employers(:two)
    job_listing = job_listings(:one)

    login_employer(employer)
    get edit_job_listing_url(job_listing)
    assert_response :success
  end

  test "should update job_listing" do
    employer = employers(:two)
    job_listing = job_listings(:one)

    login_employer(employer)
    patch job_listing_url(job_listing), params: { job_listing: { description: job_listing.description, location: job_listing.location, salary: job_listing.salary, title: job_listing.title } }
    assert_redirected_to my_company_job_listings_path
  end

  test "should destroy job_listing" do
    employer = employers(:two)
    job_listing = job_listings(:one)

    login_employer(employer)
    assert_difference("JobListing.count", -1) do
      delete job_listing_url(job_listing)
    end

    assert_redirected_to my_company_job_listings_path
  end
end
