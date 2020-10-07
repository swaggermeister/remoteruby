require "application_system_test_case"

class JobListingsTest < ApplicationSystemTestCase
  setup do
    @job_listing = job_listings(:one)
    @employer = employers(:two)
  end

  test "visiting the index" do
    visit job_listings_url
    assert_selector "button", text: "Sort Jobs by Salary"
  end

  test "creating a Job listing" do
    visit job_listings_url
    click_on "Employers"
    fill_in "Email", with: @employer.email
    fill_in "Password", with: @employer.password
    click_on "Log In"

    click_on "Add a new listing"

    fill_in "job_listing[description]", with: @job_listing.description
    fill_in "Location", with: @job_listing.location
    fill_in "Salary", with: @job_listing.salary
    fill_in "Title", with: @job_listing.title
    fill_in "job_listing[contact_email]", with: @job_listing.contact_email
    click_on "Create Listing"

    assert_text "Job listing was successfully created."
    click_on "View Profile"
  end

  test "updating a Job listing" do
    visit job_listings_url
    click_on "Employers"
    fill_in "Email", with: @employer.email
    fill_in "Password", with: @employer.password
    click_on "Log In"

    click_on "Update Listing", match: :first
    fill_in "job_listing[description]", with: "New test description"
    fill_in "Salary", with: "New test salary"
    click_on "Update Listing"

    assert_text "Job listing was successfully updated."
    click_on "View Profile"
  end

  test "destroying a Job listing" do
    visit job_listings_url
    click_on "Employers"
    fill_in "Email", with: @employer.email
    fill_in "Password", with: @employer.password
    click_on "Log In"

    page.accept_confirm do
      click_on "Delete Listing"
    end

    assert_text "Job listing was successfully destroyed."
  end
end
