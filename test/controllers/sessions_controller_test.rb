require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    employer = employers(:one)

    post login_url, params: { email: employer.email, password: "secret" }
    assert_redirected_to my_company_job_listings_path
    assert_equal employer.id, session[:employer_id]
  end

  test "should fail login" do
    employer = employers(:one)

    post login_url, params: { email: employer.email, password: "wrong" }
    assert_redirected_to login_url
  end

  test "should fail to create account when missing PW confirmation" do
    assert_no_difference("Employer.count") do
      post employers_url, params: {
                                    employer: {
                                      email: "anemployer@test.com",
                                      name: "A New Employer",
                                      password: "newtestpassword",
                                    },
                                  }
    end
  end

  test "should log out" do
    delete logout_url
    assert_redirected_to job_listings_url
  end
end
