FROM ruby:2.3.4
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /react-twitter-api
WORKDIR /react-twitter-api
ADD Gemfile /react-twitter-api/Gemfile
ADD Gemfile.lock /react-twitter-api/Gemfile.lock
RUN bundle install
ADD . /react-twitter-api
