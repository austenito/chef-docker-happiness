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
  source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/happiness-service/Dockerfile'
  # source '/vagrant/docker-files/happiness-service/Dockerfile'
  action :build_if_missing
  cmd_timeout 900
end

docker_container('happiness-service') { action :stop }
docker_container('happiness-service') { action :remove }
execute('remove cid') { command 'rm -f /var/run/happiness-service.cid' }

docker_container 'happiness-service' do
  image 'ubuntu:happiness-service'
  container_name "happiness-service"
  detach true
  env ["LOGENTRIES_TOKEN=#{ENV['LOGENTRIES_TOKEN']}"]
  link ['postgres-production:db']
  action :run
  port '3000:3000'
end
