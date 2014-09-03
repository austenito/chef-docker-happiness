# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

remote_directory '/tmp/happiness' do
  source 'happiness'
end

docker_image 'austenito/happiness-frontend' do
  source '/tmp/happiness'
  action :pull_if_missing
  cmd_timeout 900
end

if `sudo docker ps -a | grep frontend,`.size > 0
  execute('stop container') { command "docker stop -t 60 frontend" }
  execute('remove container') { command "docker rm -f frontend" }
end

docker_container 'frontend' do
  image 'austenito/happiness-frontend'
  container_name "frontend"
  detach true
  env ["LOGENTRIES_HAPPINESS_TOKEN=#{node['logentries']['happiness']}",
       "POPTART_API_TOKEN=#{node['poptart']['token']}"
      ]
  link ['postgres:db', 'happiness-service:happiness-service']
  volumes_from 'happiness-data'
  action :run
  port '3001:3001'
end
