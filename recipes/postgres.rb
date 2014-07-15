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

execute('stop container') { command "docker stop -t 60 postgres-production" }
execute('remove container') { command "docker rm -f postgres-production" }

docker_container 'postgres-production' do
  image 'ubuntu:postgres-production'
  container_name 'postgres-production'
  port "5432:5432"
  detach true
  env ["POSTGRES_USER=#{node['postgres']['user']}",
       "POSTGRES_PASSWORD=#{node['postgres']['password']}"
      ]
  volumes_from 'happiness-data'
  action :run
  working_directory '/apps/happiness_service'
end
