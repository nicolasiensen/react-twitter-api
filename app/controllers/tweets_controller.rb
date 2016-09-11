class TweetsController < ApplicationController
  def index
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = params[:twitter_access_token]
      config.access_token_secret = params[:twitter_access_token_secret]
    end

    render json: client.home_timeline
  end
end
