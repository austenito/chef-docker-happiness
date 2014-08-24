#!/bin/bash

source /usr/local/share/chruby/chruby.sh

mkdir /apps
cd /apps

git clone https://github.com/austenito/happiness_service.git
cd happiness_service
export GEM_HOME=/gems/ruby/2.1.2
mkdir pids
mkdir log
chruby 2.1.2
bundle install --without development test

export HAPPINESS_SERVICE_IP=`ifconfig eth0 | grep 'inet ' | awk -F'[: ]+' '{ print $4 }'`
sed -i "s/DEFAULT_HOST_URL/${HAPPINESS_SERVICE_IP}/" app/controllers/application_controller.rb
sed -i "s/DEFAULT_HOST_PORT/3000/" app/controllers/application_controller.rb

bundle exec rake db:create db:migrate db:seed RAILS_ENV=production
bundle exec rake assets:precompile RAILS_ENV=production
bundle exec unicorn_rails -c config/unicorn.rb -E production -p 3000
