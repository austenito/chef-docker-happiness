#
# Cookbook Name:: chef-docker-happiness
# Recipe::nginx
#

include_recipe 'docker'

remote_directory '/tmp/nginx' do
  source 'nginx'
end

docker_image 'austenito/happiness-nginx' do
  source '/tmp/nginx'
  tag '1.4.6'
  action :build
  cmd_timeout 900
end

if `sudo docker ps -a | grep nginx`.size > 0
  execute('stop container') { command "docker stop -t 60 nginx" }
  execute('remove container') { command "docker rm -f nginx" }
end

docker_container 'nginx' do
  image 'austenito/happiness-nginx:1.4.6'
  container_name 'nginx'
  port "80:80"
  link ['frontend:frontend', 'happiness-service:happiness-service']
  volumes_from 'happiness-data'
  detach true
  action :run
end
