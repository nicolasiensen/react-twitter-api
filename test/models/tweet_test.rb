require 'test_helper'

class TweetTest < ActiveSupport::TestCase
  test "should validate uniqueness of uuid scoped to user_id" do
    Tweet.create user_id: 1, uuid: "123"
    tweet = Tweet.create user_id: 1, uuid: "123"

    assert tweet.errors[:uuid].include?("has already been taken")
  end

  test "should validate presence of user_id" do
    tweet = Tweet.create
    assert tweet.errors[:user_id].include?("can't be blank")
  end

  test "should validate presence of uuid" do
    tweet = Tweet.create
    assert tweet.errors[:uuid].include?("can't be blank")
  end

  test "should be archived" do
    tweet = Tweet.create user_id: 1, uuid: "123"
    tweet.archive!
    assert tweet.archived_at.present?
  end
end
