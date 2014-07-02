#
# Cookbook Name:: chef-docker-happiness-service
# Recipe::nginx
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'app-data'
  source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/app-data/Dockerfile'
  # source '/vagrant/docker-files/postgres-data'
  action :build_if_missing
end

docker_container 'app-data' do
  image 'ubuntu:app-data'
  container_name 'app-data'
  detach true
  action :run
end
