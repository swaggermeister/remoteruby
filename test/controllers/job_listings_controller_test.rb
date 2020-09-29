require "test_helper"

class JobListingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @job_listing = job_listings(:one)
  end

  test "should get index" do
    get job_listings_url
    assert_response :success
  end

  test "should get new" do
    get new_job_listing_url
    assert_response :success
  end

  test "should create job_listing" do
    assert_difference("JobListing.count") do
      post job_listings_url, params: { job_listing: { description: @job_listing.description, location: @job_listing.location, salary: @job_listing.salary, title: @job_listing.title } }
    end

    assert_redirected_to my_company_job_listings_path
  end

  test "should show job_listing" do
    get job_listing_url(@job_listing)
    assert_response :success
  end

  test "should get edit" do
    get edit_job_listing_url(@job_listing)
    assert_response :success
  end

  test "should update job_listing" do
    patch job_listing_url(@job_listing), params: { job_listing: { description: @job_listing.description, location: @job_listing.location, salary: @job_listing.salary, title: @job_listing.title } }
    assert_redirected_to my_company_job_listings_path
  end

  test "should destroy job_listing" do
    assert_difference("JobListing.count", -1) do
      delete job_listing_url(@job_listing)
    end

    assert_redirected_to my_company_job_listings_path
  end
end
