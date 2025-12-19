#!/bin/bash
cd /var/www/app
rm tmp/pids/*
bundle exec rails db:create
bundle exec rails db:migrate
bundle exec rails db:seed
bundle exec rails assets:precompile
if [ "$RAILS_ENV" == "test" ]; then
  #DO NOTHING, TEST WILL BE STARTED THROUGH gh action
  tail -f /dev/null
else
  RAILS_ENV=production bundle exec rails s -b 0.0.0.0 -p3000
fi