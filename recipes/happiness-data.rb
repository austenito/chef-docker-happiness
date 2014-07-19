#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: happiness-data
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'happiness-data'
  source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/happiness-data/Dockerfile'
  action :build_if_missing
end

docker_container 'happiness-data' do
  image 'ubuntu:happiness-data'
  container_name 'happiness-data'
  detach true
  action :run
end
