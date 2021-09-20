# frozen_string_literal: true

require "application_system_test_case"

class EmployersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    OmniAuth.config.mock_auth[:Google] = nil
  end

  test "Creating an Employer successfully via regular authentication" do
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

  test "failing to create an employer with missing fields" do
  end

  test "Creating an Employer successfully via OmniAuth Google" do
    visit job_listings_url
    click_on "Employers"

    enable_omniauth_test_mode
    mock_google_auth_hash

    click_on "Sign in with Google"

    assert_current_path my_company_job_listings_path
    assert_text "Successfully authenticated from Google account."
  end

  test "Does not create Employer with invalid OmniAuth credentials" do
    visit job_listings_url
    click_on "Employers"

    enable_omniauth_test_mode
    OmniAuth.config.mock_auth[:Google] = :invalid_credentials

    click_on "Sign in with Google"

    assert_current_path new_employer_session_path
    assert_text 'Could not authenticate you from Google because "Invalid credentials".'
  end

  test "Updating an Employer" do
    employer = create_employer!(password: "systemtestpw")

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path
    click_on "View Profile"

    fill_in "Company Name", with: "A Test String"
    attach_file "Logo", file_fixture("bread.jpg")
    fill_in "Password", with: "systemtestpw"
    fill_in "Confirm:", with: "systemtestpw"
    click_on "Update Account"

    assert_text "Account successfully updated."
    assert employer.avatar.attached?
    click_on "My Job Listings"
  end

  test "failing to update an employer with missing fields" do
  end

  test 'profile page with no listings added yet' do
  end

  test "profile page shows only the employer's listings" do
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
