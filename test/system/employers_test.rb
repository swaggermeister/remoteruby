require "application_system_test_case"

class EmployersTest < ApplicationSystemTestCase
  setup do
    @employer = employers(:one)
  end

  test "visiting the index" do
    visit job_listings_url
    assert_selector "h1", text: "Job Listings"
  end

  test "creating a Employer" do
    visit job_listings_url
    click_on "Employers"
    click_on "Create an Account"

    fill_in "Email", with: @employer.email
    fill_in "Name", with: @employer.name
    fill_in "Password", with: @employer.password
    click_on "Create Account"

    assert_text "Account successfully created"
    click_on "My Job Listings"
  end

  test "updating a Employer" do
    visit job_listings_url
    click_on "Employers"
    fill_in "Email", with: @employer.email
    fill_in "Password", with: @employer.password
    click_on "Log In"
    click_on "View Profile"

    fill_in "Company Name", with: "A Test String"
    click_on "Update Account"

    assert_text "Account successfully updated."
    click_on "My Job Listings"
  end

  test "destroying a Employer" do
    visit job_listings_url
    click_on "Employers"
    fill_in "Email", with: @employer.email
    fill_in "Password", with: @employer.password
    click_on "Log In"
    click_on "View Profile"

    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_current_path job_listings_path
    byebug
    assert_text "Account was successfully deleted."
  end
end
