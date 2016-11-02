class OauthController < ApplicationController
  def request_token
    request_token = consumer.get_request_token

    render json: {
      authorize_url: request_token.authorize_url,
      token: request_token.token,
      secret: request_token.secret
    }
  end

  def access_token
    request_token = OAuth::RequestToken.from_hash(
      consumer,
      oauth_token: params[:oauth_token],
      oauth_token_secret: params[:oauth_token_secret]
    )

    access_token = consumer.get_access_token(request_token, oauth_verifier: params[:oauth_verifier])

    render json: {token: access_token.token, secret: access_token.secret}
  end

  def consumer
    OAuth::Consumer.new(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET'], site: "https://api.twitter.com")
  end
end
