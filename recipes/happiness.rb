# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'austenito/ruby-2.1.2'

if File.exists?('/var/run/happiness.cid')
  f = File.open('/var/run/happiness.cid', 'r')
  cid = ''
  f.each_line do |line|
    cid = line
  end

  execute('stop container') { command "docker stop -t 60 #{cid}" }
  execute('remove container') { command "docker rm -f #{cid}" }
  execute('remove cid') { command 'rm -f /var/run/happiness.cid' }
end

docker_container 'happiness' do
  image 'austenito/ruby-2.1.2'
  container_name "happiness"
  detach true
  env ["LOGENTRIES_HAPPINESS_TOKEN=#{ENV['LOGENTRIES_HAPPINESS_TOKEN']}", "POPTART_API_TOKEN=#{ENV['POPTART_API_TOKEN']}"]
  link ['postgres-production:db', 'happiness-service:happiness_service']
  volumes_from 'happiness-data'
  action :run
  port '3001:3001'
  command '/config/happiness/run.sh'
end
