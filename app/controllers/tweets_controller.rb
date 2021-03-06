class TweetsController < ApplicationController
  def index
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = params[:twitter_access_token]
      config.access_token_secret = params[:twitter_access_token_secret]
    end

    user = User.joins(:access_tokens).where("access_tokens.token = ?", params[:twitter_access_token]).first

    begin
      home_timeline = client.home_timeline(tweet_mode: "extended")

      home_timeline.each do |tweet|
        Tweet.create user_id: user.id, uuid: tweet.id, data: tweet
      end
    rescue Twitter::Error::TooManyRequests
    end

    tweets = Tweet.where(user_id: user.id, archived_at: nil).order(created_at: :desc)

    render json: {
      tweets: tweets.limit(20).map(&:data),
      total: tweets.count
    }
  end

  def archive
    user = User.joins(:access_tokens).where("access_tokens.token = ?", params[:twitter_access_token]).first

    if user.nil?
      @error_message = "User with Twitter access token #{params[:twitter_access_token]} was not found"
      return render 'shared/error', status: 404
    end

    tweet = Tweet.find_by(uuid: params[:id], user_id: user.id)

    if tweet.nil?
      @error_message = "Tweet with ID #{params[:id]} was not found"
      return render 'shared/error', status: 404
    end

    tweet.archive!
    head 204
  end
end
