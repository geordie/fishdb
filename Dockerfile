FROM ruby:3.3.1-slim
ENV LANG C.UTF-8

RUN apt-get update -qq && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    less \
    git \
    telnet \
    nodejs \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN apt-get update -qq && apt-get install -y default-libmysqlclient-dev

#Cache bundle install
WORKDIR /tmp
COPY ./Gemfile ./
RUN bundle install

ENV APP_ROOT=/workspace
RUN mkdir -p $APP_ROOT
WORKDIR $APP_ROOT
COPY . $APP_ROOT

# Install gems in the app directory
RUN bundle install

EXPOSE 3002
CMD ["sh", "-c", "echo 'Starting Rails application...' && pwd && ls -la && echo 'Running bundle exec rake db:create...' && RAILS_ENV=development bundle exec rake db:create && echo 'Running bundle exec rake db:migrate...' && RAILS_ENV=development bundle exec rake db:migrate && echo 'Starting Rails server...' && rm -f tmp/pids/server.pid && RAILS_ENV=development bundle exec rackup config.ru -o 0.0.0.0 -p 3002"]