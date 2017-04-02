require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should validate attributes" do
    user = User.create
    assert user.errors[:uuid].include?("can't be blank"), "should validate presence of uuid"

    User.create(uuid: "123")
    user = User.create(uuid: "123")
    assert user.errors[:uuid].include?("has already been taken"), "should validate uniqueness of uuid"
  end
end
