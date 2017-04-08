class TweetsController < ApplicationController
  def index
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = params[:twitter_access_token]
      config.access_token_secret = params[:twitter_access_token_secret]
    end

    user = User.joins(:access_tokens).where("access_tokens.token = ?", params[:twitter_access_token]).first
    home_timeline = client.home_timeline

    home_timeline.each do |tweet|
      Tweet.create user_id: user.id, uuid: tweet.id, data: tweet
    end

    render json: { tweets: Tweet.where(user_id: user.id).limit(20).map(&:data) }
  end
end
