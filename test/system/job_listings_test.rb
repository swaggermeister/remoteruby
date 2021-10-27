# frozen_string_literal: true

require "application_system_test_case"

# rubocop:disable Metrics/ClassLength
class JobListingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "visiting the index" do
    visit job_listings_url
    assert_text "Sort Jobs by"
  end

  test "sorting job listings" do
    # create two job listings with diff salaries
    # make sure higher salary is first
    higher_salary_employer = create_employer!
    create_job_listing!(employer: higher_salary_employer, fixed_amount: "98k")
    lower_salary_employer = create_employer!
    create_job_listing!(employer: lower_salary_employer, fixed_amount: "80k")

    visit job_listings_url

    # Sort by salary
    click_on "Hourly"

    # Sort choice was updated to show as active selection
    find(".active", text: "Hourly")

    # Listings are sorted
    listings = all(".job-listing")
    assert listings.count == 2
    assert listings.first.has_text?("98k")
  end

  test "pagination works" do
    employer = create_employer!
    11.times do
      create_job_listing!(employer: employer)
    end

    # Number of listings on the page matches the pagination count set
    visit job_listings_url
    listings = all(".job-listing")
    assert listings.count == JobListings::IndexUseCase::PAGINATION_COUNT

    # Going to the next page shows the last listing
    click_on "2"
    find(".job-listing")
    listings = all(".job-listing")
    assert listings.count == 1
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
    apply_url_button = find("#job_listing_#{job_listing.id}-apply-url", match: :first)

    assert_equal apply_url_button["href"], job_listing.contact_url
  end

  test "applying to a listing with a contact email" do
    employer = create_employer!
    job_listing = create_job_listing!(employer: employer, title: "Best job", contact_email: "bread@bread.com")
    contact_email_mailto = "mailto:#{job_listing.contact_email}"

    visit job_listings_url
    click_on "Best job"
    apply_email_button = find("#job_listing_#{job_listing.id}-apply-email", match: :first)

    assert_equal apply_email_button["href"], contact_email_mailto
  end

  test "search functionality - correct match" do
    employer = create_employer!
    create_job_listing!(employer: employer, title: "Search Engineer")
    selector = "div.card"

    visit job_listings_url
    fill_in "Search", with: "Search Engineer"
    find(".search-form__input").send_keys :return

    assert has_css?(selector, count: 1)
  end

  test "search functionality - no results" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url

    fill_in "Search", with: "bread"
    find(".search-form__input").send_keys :return

    assert_text "No results for your search."
  end

  test "creating a Job listing with fixed amount pay successfully" do
    employer = create_employer!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Add a new job listing"

    fill_in "job_listing[description]", with: "Test Job Description"
    fill_in "Location", with: "NYC"
    hourly_amount_label = find("label[for=compensation_type_hourly]")
    hourly_amount_label.click
    fill_in "job_listing[fixed_amount]", with: "20 breads"
    fill_in "Title", with: "Rails Engineer"
    fill_in "job_listing[contact_email]", with: "testco@place.com"
    click_on "Create Listing"

    assert_text "Job listing was successfully created."
  end

  test "creating a job listing with salary range successfully" do
    employer = create_employer!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Add a new job listing"

    fill_in "job_listing[description]", with: "Test Job Description"
    fill_in "Location", with: "NYC"
    # salary_range_label = find("label[for=compensation_type_salary]")
    # salary_range_label.click
    fill_in "job_listing[minimum_salary]", with: 100_000
    fill_in "job_listing[maximum_salary]", with: 150_000
    fill_in "Title", with: "Rails Engineer"
    fill_in "job_listing[contact_email]", with: "testco@place.com"
    click_on "Create Listing"

    assert_text "Job listing was successfully created."
  end

  test "fail to create a job listing with missing fields" do
    employer = create_employer!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Add a new job listing"
    fill_in "job_listing[description]", with: "Test Job Description"
    fill_in "Location", with: "NYC"
    hourly_amount_label = find("label[for=compensation_type_hourly]")
    hourly_amount_label.click
    fill_in "job_listing[fixed_amount]", with: "200000"
    fill_in "Title", with: "Rails Engineer"

    click_on "Create Listing"
    assert_text "Please add a contact email or URL"
  end

  test "updating a Job listing successfully" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Edit", match: :first
    fill_in "job_listing[description]", with: "New test description"
    fill_in "job_listing[fixed_amount]", with: "New test salary"
    click_on "Update"

    assert_text "Job listing was successfully updated."
    click_on "Update Company Profile"
  end

  test "fail to update a job listing with missing/removed fields" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Edit", match: :first
    title_field = find("#job_listing_title")
    title_field.native.clear
    click_on "Update"

    assert_text "Title can't be blank"
  end

  test "shows error when invalid URL format is entered (without http:// or https://)" do
    employer = create_employer!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    click_on "Add a new job listing"
    assert_text "Tell us about the job"

    fill_in "job_listing[description]", with: "Test Job Description"
    fill_in "Location", with: "NYC"
    hourly_amount_label = find("label[for=compensation_type_hourly]")
    hourly_amount_label.click
    fill_in "job_listing[fixed_amount]", with: "200000"
    fill_in "Title", with: "Rails Engineer"
    contact_url_label = find("label[for=contact_method_url]")
    contact_url_label.click
    fill_in "job_listing[contact_url]", with: "bread.com"
    click_on "Create Listing"

    assert_text "must start with https:// or http://"
  end

  test "destroying a Job listing" do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer
    visit my_company_job_listings_path

    page.accept_confirm do
      click_on "Delete"
    end
    assert_current_path my_company_job_listings_path
    assert_text "Job listing was successfully destroyed."
  end
end

# rubocop:enable Metrics/ClassLength
