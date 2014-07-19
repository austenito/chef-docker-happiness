#
# Cookbook Name:: chef-docker-happiness-service
# Recipe::nginx
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'austenito/nginx'

if `sudo docker ps -a | grep nginx`.size > 0
  execute('stop container') { command "docker stop -t 60 nginx" }
  execute('remove container') { command "docker rm -f nginx" }
end

docker_container 'nginx' do
  image 'austenito/nginx'
  container_name 'nginx'
  port "80:80"
  link ['happiness:happiness', 'happiness-service:happiness_service']
  volumes_from 'happiness-data'
  detach true
  action :run
end
