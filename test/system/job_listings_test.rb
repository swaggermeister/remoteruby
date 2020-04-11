require "application_system_test_case"

class JobListingsTest < ApplicationSystemTestCase
  setup do
    @job_listing = job_listings(:one)
  end

  test "visiting the index" do
    visit job_listings_url
    assert_selector "h1", text: "Job Listings"
  end

  test "creating a Job listing" do
    visit job_listings_url
    click_on "New Job Listing"

    fill_in "Description", with: @job_listing.description
    fill_in "Location", with: @job_listing.location
    fill_in "Salary", with: @job_listing.salary
    fill_in "Title", with: @job_listing.title
    click_on "Create Job listing"

    assert_text "Job listing was successfully created"
    click_on "Back"
  end

  test "updating a Job listing" do
    visit job_listings_url
    click_on "Edit", match: :first

    fill_in "Description", with: @job_listing.description
    fill_in "Location", with: @job_listing.location
    fill_in "Salary", with: @job_listing.salary
    fill_in "Title", with: @job_listing.title
    click_on "Update Job listing"

    assert_text "Job listing was successfully updated"
    click_on "Back"
  end

  test "destroying a Job listing" do
    visit job_listings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Job listing was successfully destroyed"
  end
end
