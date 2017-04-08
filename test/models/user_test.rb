require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate presence of uuid" do
    user = User.create
    assert user.errors[:uuid].include?("can't be blank")
  end

  test "should validate uniqueness of uuid" do
    User.create(uuid: "123")
    user = User.create(uuid: "123")
    assert user.errors[:uuid].include?("has already been taken")
  end

  test "should have many access tokens" do
    user = User.create(uuid: "123")
    AccessToken.create(user_id: user.id, token: "123")
    AccessToken.create(user_id: user.id, token: "321")
    assert_equal user.access_tokens.count, 2
  end
end
