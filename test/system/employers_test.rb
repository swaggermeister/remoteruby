# frozen_string_literal: true

require "application_system_test_case"

class EmployersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "Visiting the index" do
    visit job_listings_url
    assert_selector "button", text: "Sort Jobs by Salary"
  end

  test "Creating an Employer successfully" do
    visit job_listings_url
    click_on "Employers"

    fill_in "Email", with: "YetAnotherEmail@email.com"
    fill_in "Name", with: "Cool Test Co"
    fill_in "Password", with: "testsecretpassword"
    fill_in "Password confirmation", with: "testsecretpassword"
    click_on "Create Account"

    assert_current_path root_path
    assert_text "A message with a confirmation link has been sent to your email"
  end

  test "Updating an Employer" do
    employer = create_employer!(password: "systemtestpw")

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path
    click_on "View Profile"

    fill_in "Company Name", with: "A Test String"
    fill_in "Password", with: "systemtestpw"
    fill_in "Confirm:", with: "systemtestpw"
    click_on "Update Account"

    assert_text "Account successfully updated."
    click_on "My Job Listings"
  end

  test "Destroying an Employer" do
    employer = create_employer!

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path
    click_on "View Profile"

    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_current_path job_listings_path
    assert_text "Account was successfully deleted."
  end
end
