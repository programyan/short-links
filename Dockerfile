FROM ruby:2.6.3-alpine

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./

RUN bundle install --without development test

COPY . .

ENTRYPOINT ["bundle", "exec", "rackup", "--host", "0.0.0.0", "-p", "5000"]
