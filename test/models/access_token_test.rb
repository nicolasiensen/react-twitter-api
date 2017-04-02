require 'test_helper'

class AccessTokenTest < ActiveSupport::TestCase
  test "should validate attributes" do
    access_token = AccessToken.create
    assert access_token.errors[:token].include?("can't be blank"), "should validate presence of token"
    assert access_token.errors[:user_id].include?("can't be blank"), "should validate presence of user_id"

    AccessToken.create(token: "123", user_id: 1)
    access_token = AccessToken.create(token: "123", user_id: 1)
    assert(
      access_token.errors[:token].include?("has already been taken"),
      "should validate uniqueness of token scoped to user_id"
    )
  end
end
