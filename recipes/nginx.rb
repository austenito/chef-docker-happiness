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
  tag 'nginx'
  source 'https://raw.githubusercontent.com/austenito/happiness-kitchen/master/docker-files/nginx/Dockerfile'
  # source '/vagrant/docker-files/postgres/Dockerfile'
  action :build_if_missing
end

docker_container('nginx') { action :stop }
docker_container('nginx') { action :remove }
execute('remove cid') { command 'rm -f /var/run/nginx.cid' }

docker_container 'nginx' do
  image 'ubuntu:nginx'
  container_name 'postgres-nginx'
  port "80:80"
  link ['happiness:happiness', 'happiness-service:happiness_service']
  detach true
  action :run
end
