require 'test_helper'

class TweetsControllerTest < ActionDispatch::IntegrationTest
  test "returns timeline tweets" do
    VCR.use_cassette("twitter_home_timeline") do
      fixture = YAML.load_file("#{Rails.root}/test/vcr_cassettes/twitter_home_timeline.yml")

      get "/", params: {twitter_access_token: "123", twitter_access_token_secret: "321"}

      assert_equal(
        JSON.parse(fixture["http_interactions"][0]["response"]["body"]["string"]),
        response.parsed_body
      )
    end
  end
end
