# frozen_string_literal: true

require 'test_helper'

class EmployersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test 'should get new' do
    get new_employer_registration_path

    assert_response :success
  end

  test 'should create employer' do
    assert_difference('Employer.count') do
      post employer_registration_path, params: {
        employer: {
          email: 'anemployer@test.com',
          name: 'A New Employer',
          password: 'newtestpassword'
        }
      }
    end

    assert_redirected_to root_path
    assert_equal 'A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.',
                 flash[:notice]
  end

  test 'should show employer' do
    employer = create_employer!
    sign_in employer

    get my_company_job_listings_path(employer)
    assert_response :success
  end

  test 'should get edit' do
    employer = create_employer!
    sign_in employer

    get edit_employer_path(employer)
    assert_response :success
  end

  test 'should update employer' do
    employer = create_employer!
    sign_in employer

    patch employer_path(employer),
          params: { employer: { email: employer.email, name: employer.name, password: employer.password } }

    assert_equal 'Account successfully updated.', flash[:notice]
  end

  test 'should destroy employer' do
    employer = create_employer!
    sign_in employer

    assert_difference('Employer.count', -1) do
      delete employer_url(employer)
    end

    assert_redirected_to job_listings_url
  end
end
