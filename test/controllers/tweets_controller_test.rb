require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should list unarchived tweets" do
    VCR.use_cassette("twitter_home_timeline") do
      token = "123"
      secret = "321"
      user = User.create(uuid: "16239678")
      access_token = AccessToken.create(user_id: user.id, token: token)

      assert_difference("Tweet.where(user_id: #{user.id}).count", 20) do
        get "/", params: {twitter_access_token: token, twitter_access_token_secret: secret}
      end

      assert_equal 200, response.status
      assert_equal 20, JSON.parse(response.body)["tweets"].size
      assert_equal 20, JSON.parse(response.body)["total"]

      assert_no_difference("Tweet.where(user_id: #{user.id}).count") do
        get "/", params: {twitter_access_token: token, twitter_access_token_secret: secret}
      end

      Tweet.where(user_id: user.id).first.archive!
      get "/", params: {twitter_access_token: token, twitter_access_token_secret: secret}
      assert_equal 19, JSON.parse(response.body)["tweets"].size
      assert_equal 19, JSON.parse(response.body)["total"]
    end
  end
end
