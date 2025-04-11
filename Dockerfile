FROM ruby:3.4.2
RUN apt-get update -qq && apt-get install -y vim postgresql-client
RUN mkdir /server
WORKDIR /server
COPY Gemfile /server/Gemfile
COPY Gemfile.lock /server/Gemfile.lock
RUN bundle install
COPY . /server

# Add a script to be executed every time the container starts.
COPY bin/docker-entrypoint /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint
ENTRYPOINT ["docker-entrypoint"]
EXPOSE 4000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]