# frozen_string_literal: true

require "application_system_test_case"

# rubocop:disable Metrics/ClassLength
class JobListingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "visiting the index" do
    visit job_listings_url
    assert_selector "a", text: "Sort Jobs by Salary"
  end

  test "sorting job listings" do
    # create two job listings with diff salaries
    # make sure higher salary is first
    higher_salary_employer = create_employer!
    create_job_listing!(employer: higher_salary_employer, salary: "98k")
    lower_salary_employer = create_employer!
    create_job_listing!(employer: lower_salary_employer, salary: "80k")

    visit job_listings_url

    # Sort by salary
    click_on "Sort Jobs by Salary"

    # Sort choice was updated
    assert_text "Sort Jobs by Newest"

    # Listings are sorted
    listings = all(".job-listing")
    assert listings.count == 2
    assert listings.first.has_text?("98k")
  end

  test "pagination works" do
  end

  test "read full job listing details" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer, title: "Best job", description: "This is a terrific job")

    visit job_listings_url
    click_on "Best job"

    assert_current_path job_listing_path(job_listing.id)
    assert_text "This is a terrific job"
  end

  test "applying to a listing with a contact url" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer, title: "Best job", contact_url: "https://bread.com/")

    visit job_listings_url
    click_on "Best job"
    apply_url_button = find("#job_listing_#{job_listing.id}-apply-url")

    assert_equal apply_url_button["href"], job_listing.contact_url
  end

  test "applying to a listing with a contact email" do
    # it doesn't redirect?
  end

  test "search functionality - correct match" do
    employer = create_employer!
    create_job_listing!(employer: employer, title: "Search Engineer")
    selector = "div.card"

    visit job_listings_url
    fill_in "Search", with: "Search Engineer"
    find("#search-form [type=submit]").click

    assert has_css?(selector, count: 1)
  end

  test "search functionality - no results" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url

    fill_in "Search", with: "bread"
    find("#search-form [type=submit]").click

    assert_text "No results for your search."
  end

  test "creating a Job listing" do
    employer = create_employer!

    visit job_listings_url
    click_on "Employers"
    sign_in employer
    visit my_company_job_listings_path

    click_on "Add a new listing"

    fill_in "job_listing[description]", with: "Test Job Description"
    fill_in "Location", with: "NYC"
    fill_in "Salary", with: "200000"
    fill_in "Title", with: "Rails Engineer"
    fill_in "job_listing[contact_email]", with: "testco@place.com"
    click_on "Create Listing"

    assert_text "Job listing was successfully created."
    click_on "View Profile"
  end

  test "fail to create a job listing with missing fields" do
  end

  test "updating a Job listing" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on "Employers"
    sign_in employer
    visit my_company_job_listings_path

    click_on "Update Listing", match: :first
    fill_in "job_listing[description]", with: "New test description"
    fill_in "Salary", with: "New test salary"
    click_on "Update Listing"

    assert_text "Job listing was successfully updated."
    click_on "View Profile"
  end

  test "fail to update a job listing with missing fields" do
  end

  test "shows error when invalid URL format is entered (without http:// or https://)" do
  end

  test "destroying a Job listing" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on "Employers"
    sign_in employer
    visit my_company_job_listings_path

    page.accept_confirm do
      click_on "Delete Listing"
    end
    assert_current_path my_company_job_listings_path
    assert_text "Job listing was successfully destroyed."
  end
end

# rubocop:enable Metrics/ClassLength
