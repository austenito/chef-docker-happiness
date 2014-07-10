#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: postgres
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'postgres-production'
  source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/postgres/Dockerfile'
  # source '/vagrant/docker-files/postgres/Dockerfile'
  action :build_if_missing
end

docker_container('postgres-production') { action :stop }
docker_container('postgres-production') { action :remove }
execute('remove cid') { command 'rm -f /var/run/postgres-production.cid' }

docker_container 'postgres-production' do
  image 'ubuntu:postgres-production'
  container_name 'postgres-production'
  port "5432:5432"
  detach true
  env ["POSTGRES_USER=#{ENV['POSTGRES_USER']}", "POSTGRES_PASSWORD=#{ENV['POSTGRES_PASSWORD']}"]
  volumes_from 'happiness-data'
  action :run
  working_directory '/apps/happiness_service'
end
