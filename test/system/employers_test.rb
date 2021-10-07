# frozen_string_literal: true

require "application_system_test_case"
# rubocop:disable Metrics/ClassLength
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

  test "Failing to create an employer with missing fields" do
    visit job_listings_url
    click_on "Employers"

    fill_in "Email", with: "YetAnotherEmail@email.com"
    fill_in "Password", with: "testsecretpassword"
    fill_in "Password confirmation", with: "testsecretpassword"
    click_on "Create Account"

    assert_text "Name can't be blank"
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

  test "resend confirmation instructions" do
    create_employer!(email: "testconfirm@confirm.com", is_confirmed: false)
    visit new_employer_confirmation_path

    assert_text "Resend confirmation instructions"

    fill_in "Email", with: "testconfirm@confirm.com"
    click_on "Resend confirmation instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions for how to confirm your email address in a few minutes."
  end

  test "resend unlock instructions" do
    create_employer!(email: "testlocked@lock.com", is_locked: true)
    visit new_employer_unlock_path

    assert_text "Resend unlock instructions"

    fill_in "Email", with: "testlocked@lock.com"
    click_on "Resend unlock instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions for how to unlock your account in a few minutes."
  end

  test "forgot password" do
    create_employer!(email: "forgotpw@reset.com")
    visit new_employer_password_path

    has_button? "Send me reset password instructions"

    fill_in "Email", with: "forgotpw@reset.com"
    click_on "Send me reset password instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions on how to reset your password in a few minutes."
  end

  test "Updating an Employer successfully" do
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

    assert_flash_text "Account successfully updated."
    assert employer.avatar.attached?
    click_on "My Job Listings"
  end

  test "Failing to update an employer with missing fields" do
    employer = create_employer!(password: "systemtestpw")

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path
    click_on "View Profile"

    fill_in "Company Name", with: "A Test String"
    name_field = find("#employer_name")
    name_field.native.clear
    attach_file "Logo", file_fixture("bread.jpg")
    fill_in "Password", with: "systemtestpw"
    fill_in "Confirm:", with: "systemtestpw"
    click_on "Update Account"

    assert_text "Name can't be blank"
    assert employer.avatar.attached?
  end

  test "avatar persists when updating profile if no new one was picked" do
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

    assert_flash_text "Account successfully updated."
    assert employer.avatar.attached?
  end

  test "Profile page with no listings added yet" do
    employer = create_employer!

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path

    assert_text "You don't have any listings yet!"
  end

  test "Profile page shows only the employer's own listings" do
    employer = create_employer!
    create_job_listing!(employer: employer, title: "Job for Employer")
    other_employer = create_employer!
    create_job_listing!(employer: other_employer, title: "Job for Other Employer")
    selector = "div.card"

    visit job_listings_url
    click_on "Sign In"
    sign_in employer
    visit my_company_job_listings_path

    assert has_css?(selector, count: 1)
    assert_text "Job for Employer"
    refute_text "Job for Other Employer"
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

# rubocop:enable Metrics/ClassLength
