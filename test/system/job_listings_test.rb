# frozen_string_literal: true

require 'application_system_test_case'

class JobListingsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test 'visiting the index' do
    visit job_listings_url
    assert_selector 'a', text: 'Sort Jobs by Salary'
  end

  test 'creating a Job listing' do
    employer = create_employer!

    visit job_listings_url
    click_on 'Employers'
    sign_in employer
    visit my_company_job_listings_path

    click_on 'Add a new listing'

    fill_in 'job_listing[description]', with: 'Test Job Description'
    fill_in 'Location', with: 'NYC'
    fill_in 'Salary', with: '200000'
    fill_in 'Title', with: 'Rails Engineer'
    fill_in 'job_listing[contact_email]', with: 'testco@place.com'
    click_on 'Create Listing'

    assert_text 'Job listing was successfully created.'
    click_on 'View Profile'
  end

  test 'updating a Job listing' do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on 'Employers'
    sign_in employer
    visit my_company_job_listings_path

    click_on 'Update Listing', match: :first
    fill_in 'job_listing[description]', with: 'New test description'
    fill_in 'Salary', with: 'New test salary'
    click_on 'Update Listing'

    assert_text 'Job listing was successfully updated.'
    click_on 'View Profile'
  end

  test 'destroying a Job listing' do
    employer = create_employer!
    create_job_listing!(employer: employer)

    visit job_listings_url
    click_on 'Employers'
    sign_in employer
    visit my_company_job_listings_path

    page.accept_confirm do
      click_on 'Delete Listing'
    end
    assert_current_path my_company_job_listings_path
    assert_text 'Job listing was successfully destroyed.'
  end
end
