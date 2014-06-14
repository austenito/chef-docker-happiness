#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'happiness-service'
  # source 'https://raw.githubusercontent.com/austenito/happiness-service-docker/master/Dockerfile'
  source '/vagrant/docker-files/happiness-service/Dockerfile'
  action :build
  cmd_timeout 900
end

docker_container 'happiness-service' do
  action :stop
  force true
end

docker_container 'happiness-service' do
  action :remove
end

execute 'remove cid' do
  command 'rm -f /var/run/happiness-service*.cid'
end

docker_container 'happiness-service' do
  image 'ubuntu:happiness-service'
  container_name "happiness-service"
  detach true
  env "POSTGRES_USER=#{ENV['POSTGRES_USER']} POSTGRES_PASSWORD=#{ENV['POSTGRES_PASSWORD']}"
end
