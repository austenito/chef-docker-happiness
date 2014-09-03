#
# Cookbook Name:: example-cookbook
# Recipe:: postgres
#

include_recipe 'docker'

remote_directory '/tmp/postgres' do
  source 'postgres'
end

docker_image 'austenito/postgres' do
  source '/tmp/postgres'
  tag '9.3'
  action :pull_if_missing
  cmd_timeout 1600
end

if `sudo docker ps -a | grep postgres`.size == 0
  docker_container 'postgres' do
    image 'austenito/postgres:9.3'
    container_name 'postgres'
    port "5432:5432"
    detach true
    env ["POSTGRES_USER=#{node['postgresql']['user']}",
         "POSTGRES_PASSWORD=#{node['postgresql']['password']}"
        ]
    volumes_from 'happiness-data'
    action :run
  end
end

