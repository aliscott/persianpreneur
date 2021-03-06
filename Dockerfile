FROM ruby:latest

RUN mkdir /src && \
    mkdir /src/log /src/tmp && \
    touch /src/log/production.log
WORKDIR /src
COPY . .

RUN bundle install
RUN RAILS_ENV=production rake assets:precompile

RUN chmod -R g+rw /src/log /src/tmp

USER 1001
EXPOSE 8080
CMD bundle exec unicorn -p 8080 -c ./config/unicorn.rb
