# frozen_string_literal: true

require "application_system_test_case"
# rubocop:disable Metrics/ClassLength
class EmployersTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  setup do
    OmniAuth.config.mock_auth[:Google] = nil
  end

  test "Creating an Employer successfully via regular authentication" do
    password_placeholder_text = "Password (#{EmployerRecord.password_length.min} characters minimum)"

    visit job_listings_url
    click_on "Post a Job", match: :first
    click_on "Create an Account"

    fill_in "Email", with: "test@email.com"
    sleep 1 # fix intermittent test failure where it would not wait for the email field to fill in before continuing sometimes
    fill_in "Company Name", with: "MyCo"
    fill_in password_placeholder_text, with: "password"
    fill_in "Confirm Password", with: "password"
    click_on "Create Account"

    assert_text "A message with a confirmation link has been sent to your email"
    assert_current_path root_path
  end

  test "Failing to create an employer with missing fields" do
    password_placeholder_text = "Password (#{EmployerRecord.password_length.min} characters minimum)"

    visit job_listings_url
    click_on "Post a Job", match: :first
    click_on "Create an Account"

    fill_in "Email", with: "YetAnotherEmail@email.com"
    fill_in password_placeholder_text, with: "testsecretpassword"
    fill_in "Confirm Password", with: "testsecretpassword"
    click_on "Create Account"

    assert_text "Name can't be blank"
  end

  test "Creating an Employer successfully via OmniAuth Google" do
    visit job_listings_url
    click_on "Post a Job", match: :first
    click_on "Create an Account"

    enable_omniauth_test_mode
    mock_google_auth_hash

    click_on "Sign in with Google"

    assert_current_path my_company_job_listings_path
    assert_text "Successfully authenticated from Google account."
  end

  test "Does not create Employer with invalid OmniAuth credentials" do
    visit job_listings_url
    click_on "Post a Job", match: :first
    click_on "Create an Account"

    enable_omniauth_test_mode
    OmniAuth.config.mock_auth[:Google] = :invalid_credentials

    click_on "Sign in with Google"

    assert_current_path new_employer_session_path
    assert_text 'Could not authenticate you from Google because "Invalid credentials".'
  end

  test "resend confirmation instructions" do
    create_employer_record!(email: "testconfirm@confirm.com", is_confirmed: false)
    visit new_employer_confirmation_path

    assert_text "Resend confirmation instructions"

    fill_in "Email", with: "testconfirm@confirm.com"
    click_on "Resend confirmation instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions for how to confirm your email address in a few minutes."
  end

  test "resend unlock instructions" do
    create_employer_record!(email: "testlocked@lock.com", is_locked: true)
    visit new_employer_unlock_path

    assert_text "Resend unlock instructions"

    fill_in "Email", with: "testlocked@lock.com"
    click_on "Resend unlock instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions for how to unlock your account in a few minutes."
  end

  test "forgot password" do
    create_employer_record!(email: "forgotpw@reset.com")
    visit new_employer_password_path

    has_button? "Send me reset password instructions"

    fill_in "Email", with: "forgotpw@reset.com"
    click_on "Send me reset password instructions"

    assert_current_path new_employer_session_path
    assert_text "You will receive an email with instructions on how to reset your password in a few minutes."
  end

  test "Updating an Employer successfully" do
    employer_record = create_employer_record!(password: "systemtestpw")
    employer = to_result_entity(record: employer_record)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path
    click_on "Update Company Profile"

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
    employer_record = create_employer_record!(password: "systemtestpw")
    employer = to_result_entity(record: employer_record)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path
    click_on "Update Company Profile"

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
    employer_record = create_employer_record!(password: "systemtestpw")
    employer = to_result_entity(record: employer_record)

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path
    click_on "Update Company Profile"

    fill_in "Company Name", with: "A Test String"
    fill_in "Password", with: "systemtestpw"
    fill_in "Confirm:", with: "systemtestpw"
    click_on "Update Account"

    assert_flash_text "Account successfully updated."
    assert employer.avatar.attached?
  end

  test "Profile page with no listings added yet" do
    employer_record = create_employer_record!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path

    assert_text "You don't have any listings yet!"
  end

  test "Profile page shows only the employer's own listings" do
    employer_record = create_employer_record!
    create_job_listing!(employer_record: employer_record, title: "Job for Employer")
    other_employer_record = create_employer_record!
    create_job_listing!(employer_record: other_employer_record, title: "Job for Other Employer")
    selector = "div.card"

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path

    assert has_css?(selector, count: 1)
    assert_text "Job for Employer"
    refute_text "Job for Other Employer"
  end

  test "Destroying an Employer" do
    employer_record = create_employer_record!

    visit job_listings_url
    click_on "Post a Job", match: :first
    sign_in employer_record
    visit my_company_job_listings_path
    click_on "Update Company Profile"

    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_current_path job_listings_path
    assert_text "Account was successfully deleted."
  end
end

# rubocop:enable Metrics/ClassLength
