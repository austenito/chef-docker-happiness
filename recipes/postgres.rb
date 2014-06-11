#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: postgres
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_container 'postgres-production' do
  action :stop
  force true
end

docker_container 'postgres-production' do
  action :remove
end

execute 'remove cid' do
  command 'rm -f /var/run/postgres-production*.cid'
end

docker_image 'ubuntu' do
  tag 'postgres-production'
  # source 'https://raw.githubusercontent.com/austenito/happiness-service-docker/master/Dockerfile'
  source '/vagrant/docker-files/postgres/Dockerfile'
  action :build
end

docker_container 'postgres-production' do
  image 'ubuntu:postgres-production'
  container_name 'postgres-production'
  port "5432:5432"
  detach true
end

execute 'set credentials' do
  command "PGPASSWORD=docker \
           psql -h localhost -U docker -p 5432 --command \"CREATE USER #{ENV['POSTGRES_USER']} WITH SUPERUSER PASSWORD '#{ENV['POSTGRES_PASSWORD']}';\""
end

# timestamp = Time.new.strftime('%Y%m%d%H%M')

# docker_container 'postgres-production' do
  # repository 'ubuntu'
  # tag "postgres-production-#{timestamp}"
  # action :commit
# end

# docker_container 'postgres-production' do
  # action :stop
  # force true
# end

# docker_container 'postgres-production' do
  # action :remove
# end

# docker_container "postgres-production" do
  # image "ubuntu:postgres-production-#{timestamp}"
  # container_name 'postgres-production'
  # publish_exposed_ports true
  # detach true
# end
