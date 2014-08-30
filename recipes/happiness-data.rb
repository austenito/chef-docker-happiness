#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: happiness-data
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

cookbook_file 'Dockerfile' do
  path '/tmp/Dockerfile'
  source 'happiness-data/Dockerfile'
end

docker_image 'ubuntu' do
  tag 'happiness-data'
  source '/tmp'
  action :build_if_missing
  cmd_timeout 900
end

docker_container 'happiness-data' do
  image 'ubuntu:happiness-data'
  container_name 'happiness-data'
  detach true
  action :run
end
