require 'test_helper'

class ArchiveATweetTest < ActionDispatch::IntegrationTest
  test "should archive the tweet" do
    user = User.create! uuid: '123'
    access_token = AccessToken.create! token: 'token123', user_id: user.id
    tweet = Tweet.create! user_id: user.id, uuid: '321'

    assert_difference -> { Tweet.where('archived_at IS NOT NULL').count }, 1 do
      put "/tweets/#{tweet.uuid}/archive", params: { twitter_access_token: access_token.token }
    end

    assert_response 204
  end

  test 'should return tweet not found' do
    user = User.create! uuid: '123'
    access_token = AccessToken.create! token: 'token123', user_id: user.id

    put "/tweets/321/archive", params: { twitter_access_token: access_token.token }

    assert_response 404
    assert JSON.parse(@response.body)['error']['message'].present?
  end

  test 'should return user not found' do
    put "/tweets/321/archive", params: { twitter_access_token: 'invalid-access-token' }

    assert_response 404
    assert JSON.parse(@response.body)['error']['message'].present?
  end
end
