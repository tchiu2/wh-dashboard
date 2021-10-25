require "test_helper"

class UserTest < ActiveSupport::TestCase
  test 'should not save a user without an email' do
    user = User.new(name: 'Foo Bar', password: 'hunter12')

    assert_not user.save, 'Saved user without an email'
  end

  test 'should not save a user without an name' do
    user = User.new(email: 'foo@bar.com', password: 'hunter12')

    assert_not user.save, 'Saved user without a name'
  end

  test 'should default to "Customer" when creating a user' do
    user = User.create(email: 'foo@bar.com', name: 'Foo Bar', password: 'hunter12')

    assert user.type == 'Customer', 'New user is not a Customer'
  end
end
