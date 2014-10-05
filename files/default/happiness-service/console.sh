#!/bin/bash

source /usr/local/share/chruby/chruby.sh

cd /apps

git clone https://github.com/austenito/happiness_service.git
cd happiness_service
export GEM_HOME=/gems/ruby/2.1.2
chruby 2.1.2
bundle install --without development test
bundle exec rails console production
