FROM ruby:3.4.2
RUN apt-get update -qq && apt-get install -y vim postgresql-client
RUN mkdir /boserikodata
WORKDIR /boserikodata
COPY Gemfile /boserikodata/Gemfile
COPY Gemfile.lock /boserikodata/Gemfile.lock
RUN bundle install
COPY . /boserikodata
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]