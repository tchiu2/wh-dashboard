require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test 'should redirect to login page if not currently logged in' do
    get users_url

    assert_redirected_to login_path
  end

  test 'should redirect to admins index if logged in as an admin user' do
    log_in_as(email: 'admin1@example.com', password: 'admin1')

    get users_url

    assert_redirected_to admins_path
  end

  test 'should redirect to customer info page if logged in as a customer' do
    log_in_as(email: 'cust1@example.com', password: 'hunter1')

    get users_url

    assert_template :show
  end
end
