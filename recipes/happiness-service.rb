#
# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness-service
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

remote_directory '/tmp/happiness-service' do
  source 'happiness-service'
end

docker_image 'austenito/happiness-service' do
  source '/tmp/happiness-service'
  action :build_if_missing
  cmd_timeout 900
end

if `sudo docker ps -a | grep happiness-service`.size > 0
  execute('stop container') { command "docker stop -t 60 happiness-service" }
  execute('remove container') { command "docker rm -f happiness-service" }
end

docker_container 'happiness-service' do
  image 'austenito/ruby-2.1.2'
  container_name "happiness-service"
  detach true
  env ["LOGENTRIES_HAPPINESS_SERVICE_TOKEN=#{node['logentries']['happiness_service']}"]
  link ['postgres:db']
  volumes_from 'happiness-data'
  action :run
  port '3000:3000'
  command '/config/happiness-service/run.sh'
end
