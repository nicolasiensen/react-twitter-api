require 'test_helper'

class LinkPreviewControllerTest < ActionDispatch::IntegrationTest
  test "should return all meta tags for the link" do
    VCR.use_cassette("link_preview") do
      get "/link_preview", params: {link: "https://twitter.com/"}
      assert_equal JSON.parse(response.body)["meta"].length, 8
    end
  end
end
