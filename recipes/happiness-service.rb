#
# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness-service
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

if File.exists?('/var/run/happiness-service.cid')
  f = File.open('/var/run/happiness-service.cid', 'r')
  cid = ''
  f.each_line do |line|
    cid = line
  end

  execute('stop container') { command "docker stop -t 60 #{cid}" }
  execute('remove container') { command "docker rm -f #{cid}" }
  execute('remove cid') { command 'rm -f /var/run/happiness-service.cid' }
end

docker_container 'happiness-service' do
  image 'ubuntu:happiness-service'
  container_name "happiness-service"
  detach true
  env ["LOGENTRIES_HAPPINESS_SERVICE_TOKEN=#{ENV['LOGENTRIES_HAPPINESS_SERVICE_TOKEN']}"]
  link ['postgres-production:db']
  action :run
  port '3000:3000'
end
