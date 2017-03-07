FROM ruby:2.1.5
MAINTAINER Wayne Lai <waynelai614@gmail.com>

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    vim

RUN mkdir /usr/src/stock_api_server
WORKDIR /usr/src/stock_api_server
ADD Gemfile /usr/src/stock_api_server/Gemfile
ADD Gemfile.lock /usr/src/stock_api_server/Gemfile.lock
RUN bundle install
ADD . /usr/src/stock_api_server

# Set the timezone.
ENV TZ=Asia/Taipei
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
