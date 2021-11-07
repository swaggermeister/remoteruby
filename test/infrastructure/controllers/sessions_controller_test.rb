# frozen_string_literal: true

require "test_helper"
require "devise"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  # include Devise::Test::IntegrationHelpers
  # include Warden::Test::Helpers

  test "should prompt for login" do
    get new_employer_session_path

    assert_response :success
  end

  test "should login" do
    password = "password1234"
    employer_record = create_employer_record!(password: password)
    employer = to_result_entity(employer_record)

    post employer_session_path, params: { employer: { email: employer.email, password: password } }

    assert_redirected_to my_company_job_listings_path
  end

  test "should fail login" do
    employer_record = create_employer_record!
    employer = to_result_entity(employer_record)

    post employer_session_path, params: { employer: { email: employer.email, password: "wrong" } }
    assert_response 200
  end

  # test "should fail to create account when missing PW confirmation" do
  #   assert_no_difference("EmployerRecord.count") do
  #     post employer_registration_path, params: {
  #                                        employer: {
  #                                          email: "anemployer@test.com",
  #                                          name: "A New Employer",
  #                                          password: "newtestpassword",
  #                                        },
  #                                      }
  #   end
  # end

  test "should log out" do
    delete destroy_employer_session_path
    assert_redirected_to root_path
  end
end
