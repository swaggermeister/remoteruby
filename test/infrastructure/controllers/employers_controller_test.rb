# frozen_string_literal: true

require "test_helper"

class EmployersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  test "should get new" do
    get new_employer_registration_path

    assert_response :success
  end

  test "should create employer" do
    assert_difference("EmployerRecord.count") do
      post employer_registration_path, params: {
        employer: {
          email: "anemployer@test.com",
          name: "A New Employer",
          password: "newtestpassword",
        },
      }
    end

    assert_redirected_to root_path
    assert_equal "A message with a confirmation link has been sent to your email address. Please follow the link to activate your account.",
                 flash[:notice]
  end

  test "should show employer" do
    employer_record = create_employer_record!
    employer = to_result_entity(record: employer_record)
    sign_in employer_record

    get my_company_job_listings_path(employer)
    assert_response :success
  end

  test "should get edit" do
    employer_record = create_employer_record!
    employer = to_result_entity(record: employer_record)
    sign_in employer_record

    get edit_employer_path(employer)
    assert_response :success
  end

  test "should update employer" do
    employer_record = create_employer_record!
    employer = to_result_entity(record: employer_record)

    sign_in employer_record

    patch employer_path(employer),
          params: { employer: { email: employer_record.email, name: employer_record.name, password: employer_record.password } }

    assert_equal "Account successfully updated.", flash[:notice]
  end

  test "should destroy employer" do
    employer_record = create_employer_record!
    employer = to_result_entity(record: employer_record)
    sign_in employer_record

    assert_difference("EmployerRecord.count", -1) do
      delete employer_url(employer)
    end

    assert_redirected_to job_listings_url
  end
end
