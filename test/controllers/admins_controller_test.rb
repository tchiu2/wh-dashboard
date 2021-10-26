require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test 'should allow admin user to login as a customer' do
    log_in_as(email: 'admin1@example.com', password: 'admin1')

    post login_as_user_admin_url(Customer.first)

    get users_url

    assert_template :show
  end

  test 'should stay logged in as admin when logging out of customer account' do
    log_in_as(email: 'admin1@example.com', password: 'admin1')

    post login_as_user_admin_url(Customer.first)

    delete logout_path

    assert_redirected_to admins_path
  end
end
