require "application_system_test_case"

class EmployersTest < ApplicationSystemTestCase
  test "Visiting the index" do
    visit job_listings_url
    assert_selector "button", text: "Sort Jobs by Salary"
  end

  test "Creating an Employer successfully" do
    visit job_listings_url
    click_on "Employers"
    click_on "Create an Account"

    fill_in "Email", with: "YetAnotherEmail@email.com"
    fill_in "Name", with: "Cool Test Co"
    fill_in "Password", with: "testsecretpassword"
    fill_in "Confirm:", with: "testsecretpassword"
    click_on "Create Account"

    assert_text "Account successfully created"
    click_on "My Job Listings"
  end

  test "Updating an Employer" do
    employer = employers(:one)

    visit job_listings_url
    click_on "Employers"
    login_employer(employer)
    visit my_company_job_listings_path
    click_on "View Profile"

    fill_in "Company Name", with: "A Test String"
    fill_in "Password", with: "secret"
    fill_in "Confirm:", with: "secret"
    click_on "Update Account"

    assert_text "Account successfully updated."
    click_on "My Job Listings"
  end

  test "Destroying an Employer" do
    employer = employers(:one)

    visit job_listings_url
    click_on "Employers"
    login_employer(employer)
    visit my_company_job_listings_path
    click_on "View Profile"

    page.accept_confirm do
      click_on "Delete Account"
    end

    assert_current_path job_listings_path
    assert_text "Account was successfully deleted."
  end
end
