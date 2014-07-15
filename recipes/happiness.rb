# Cookbook Name:: chef-docker-happiness-service
# Recipe::happiness
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'austenito/ruby-2.1.2'

execute('stop container') { command "docker stop -t 60 happiness" }
execute('remove container') { command "docker rm -f happiness" }

docker_container 'happiness' do
  image 'austenito/ruby-2.1.2'
  container_name "happiness"
  detach true
  env ["LOGENTRIES_HAPPINESS_TOKEN=#{node['logentries']['happiness_service']}",
       "POPTART_API_TOKEN=#{node['poptart']['token']}"
      ]
  link ['postgres-production:db', 'happiness-service:happiness_service']
  volumes_from 'happiness-data'
  action :run
  port '3001:3001'
  command '/config/happiness/run.sh'
end
