FROM ruby:3.2.0-alpine

RUN apk add --no-cache build-base libpq-dev tzdata git libpq-dev

ENV INSTALL_PATH /opt/app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

RUN bundle install

COPY . $INSTALL_PATH

ENTRYPOINT ["./bin/docker-entrypoint"]

EXPOSE 3333
CMD ["./bin/rails", "server"]
