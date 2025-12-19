FROM ruby:3.0.6
RUN apt-get update && apt-get install nodejs libsqlite3-dev -y
RUN gem install bundler
ADD Gemfile /tmp
ADD Gemfile.lock /tmp
WORKDIR /tmp
ADD . /var/www/app
COPY entrypoint.sh /
WORKDIR /var/www/app
RUN cd /var/www/app && bundle install
RUN ["chmod", "+x", "/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]