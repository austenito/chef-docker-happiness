# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'happiness'
  # source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/happiness/Dockerfile'
  source '/vagrant/docker-files/happiness/Dockerfile'
  action :build_if_missing
  cmd_timeout 900
end

docker_container('happiness') { action :stop }
docker_container('happiness') { action :remove; force true }
execute('remove cid') { command 'rm -f /var/run/happiness.cid' }

docker_container 'happiness' do
  image 'ubuntu:happiness'
  container_name "happiness"
  detach true
  env ["LOGENTRIES_HAPPINESS_TOKEN=#{ENV['LOGENTRIES_SERVICE_TOKEN']}"]
  link ['postgres-production:db']
  action :run
  port '3001:3001'
end
