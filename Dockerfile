FROM ruby:3.4.2
RUN apt-get update -qq && apt-get install -y vim postgresql-client
RUN mkdir /data
WORKDIR /data
COPY Gemfile /data/Gemfile
COPY Gemfile.lock /data/Gemfile.lock
RUN bundle install
COPY . /data
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]