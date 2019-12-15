FROM ruby:2.6.5

# Run updates
# See:
# https://yourmystar-engineer.hatenablog.jp/entry/2019/07/15/140644
RUN apt-get update -qq && apt-get install -y build-essential default-mysql-client

# Yarn: Fast, reliable, and secure dependency management.
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_13.x | bash - \
        && apt-get install -y gcc g++ make nodejs

# Set locale to input multibyte character
# See:
# https://blog.unresolved.xyz/docker-multibyte/
# Install language pack for Debian
RUN apt-get update -qq && apt-get install -y task-japanese
ENV LANG C.UTF-8

# Set root dir for app
ENV HOME /root
ENV APP_ROOT /usr/local/app

RUN mkdir $APP_ROOT
WORKDIR $APP_ROOT

# from file path in host to file path in Docker image
COPY Gemfile* $APP_ROOT/

# Install gems
RUN bundle install && bundle clean

# Upload source
COPY . $APP_ROOT
