#
# Cookbook Name:: chef-docker-happiness
# Recipe::nginx
#

include_recipe 'docker'

remote_directory '/tmp/nginx' do
  source 'nginx'
end

docker_image 'austenito' do
  source '/tmp/nginx'
  tag 'nginx'
  action :build_if_missing
  cmd_timeout 900
end

if `sudo docker ps -a | grep nginx`.size > 0
  execute('stop container') { command "docker stop -t 60 nginx" }
  execute('remove container') { command "docker rm -f nginx" }
end

docker_container 'nginx' do
  image 'austenito:nginx'
  container_name 'nginx'
  port "80:80"
  link ['happiness:happiness', 'happiness-service:happiness_service']
  volumes_from 'happiness-data'
  detach true
  action :run
end
