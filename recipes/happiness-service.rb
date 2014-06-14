#
# Cookbook Name:: chef-docker-happiness-service
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'ubuntu' do
  tag 'happiness-service'
  # source 'https://raw.githubusercontent.com/austenito/happiness-service-docker/master/Dockerfile'
  source '/vagrant/docker-files/happiness-service/Dockerfile'
  action :build
  cmd_timeout 900
end

docker_container 'happiness-service' do
  action :stop
  force true
end

docker_container 'happiness-service' do
  action :remove
end

execute 'remove cid' do
  command 'rm -f /var/run/happiness-service*.cid'
end

docker_container 'happiness-service' do
  image 'ubuntu:happiness-service'
  container_name "happiness-service"
  # command "bash -c 'source /usr/local/share/chruby/chruby.sh && \
                    # git clone https://github.com/austenito/happiness_service.git && \
                    # cd happiness_service && \
                    # chruby 2.1.2 && \
                    # bundle install && \
                    # rake db:create db:migrate'"
  detach true
  env "POSTGRES_USER=#{ENV['POSTGRES_USER']} POSTGRES_PASSWORD=#{ENV['POSTGRES_PASSWORD']}"
end

# timestamp = Time.new.strftime('%Y%m%d%H%M')

# Commit container changes
# docker_container 'happiness-service' do
  # repository 'ubuntu'
  # tag "happiness-service-#{timestamp}"
  # action :commit
# end

# docker_container "happiness-service" do
  # image "ubuntu:happiness-service-#{timestamp}"
  # container_name "happiness-service-#{timestamp}"
  # command "bash -c 'source /usr/local/share/chruby/chruby.sh && \
                    # chruby 2.1.2 && \
                    # unicorn -p 3000'"
  # port '3000:3000'
  # detach true
  # working_directory '/home/happiness_service'
  # env "POSTGRES_USER=#{ENV['POSTGRES_USER']} POSTGRES_PASSWORD=#{ENV['POSTGRES_PASSWORD']}"
# end
