#
# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness-service
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'austenito/ruby-2.1.2'

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
  image 'austenito/ruby-2.1.2'
  container_name "happiness-service"
  detach true
  env ["LOGENTRIES_HAPPINESS_SERVICE_TOKEN=#{node['logentries']['happiness_service'][node.chef_environment]['token']}"]
  link ['postgres-production:db']
  volumes_from 'happiness-data'
  action :run
  port '3000:3000'
  command '/config/happiness-service/run.sh'
end
