require 'test_helper'

class OauthControllerTest < ActionDispatch::IntegrationTest
  setup do
    # This is the user id given by Twitter in the cassette twitter_access_token
    @user_id = "16239678"
    @oauth_token = "123"
  end

  test "GET /request_token" do
    VCR.use_cassette("twitter_request_token") do
      get "/request_token"
      assert_not_nil response.body["authorize_url"]
      assert_not_nil response.body["token"]
      assert_not_nil response.body["secret"]
    end
  end

  test "GET /access_token" do
    VCR.use_cassette("twitter_access_token") do
      get "/access_token", params: {oauth_token: @oauth_token, oauth_token_secret: "321", oauth_verifier: "123456"}

      user = User.find_by(uuid: @user_id)
      assert_not_nil user, "should create a new user"

      access_token = AccessToken.find_by(token: @oauth_token, user_id: user.id)
      assert_not_nil access_token, "should create a new access token"

      assert_not_nil response.body["token"], "should return the token"
      assert_not_nil response.body["secret"], "should return the secret"
    end
  end

  test "GET /access_token when the token already exists" do
    VCR.use_cassette("twitter_access_token") do
      user = User.create(uuid: @user_id)
      AccessToken.create(token: @oauth_token, user_id: user.id)

      assert_no_difference "AccessToken.count", "should not create the existing access token" do
        get "/access_token", params: {oauth_token: @oauth_token, oauth_token_secret: "321", oauth_verifier: "123456"}
      end
    end
  end

  test "GET /access_token when the user already exists" do
    VCR.use_cassette("twitter_access_token") do
      User.create(uuid: @user_id)

      assert_no_difference "User.count", "should not create the existing user" do
        get "/access_token", params: {oauth_token: @oauth_token, oauth_token_secret: "321", oauth_verifier: "123456"}
      end
    end
  end
end
