require 'test_helper'

class OauthControllerTest < ActionDispatch::IntegrationTest
  test "request_token" do
    VCR.use_cassette("twitter_request_token") do
      get "/request_token"
      assert response.body["authorize_url"].present?
      assert response.body["token"].present?
      assert response.body["secret"].present?
    end
  end

  test "access_token" do
    VCR.use_cassette("twitter_access_token") do
      get "/access_token", params: {oauth_token: "123", oauth_token_secret: "321", oauth_verifier: "123456"}
      assert response.body["token"].present?
      assert response.body["secret"].present?
    end
  end
end
