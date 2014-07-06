#
# Cookbook Name:: chef-docker-happiness
# Recipe:: ruby-2.1.2
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'docker'

docker_image 'austenito' do
  tag 'ruby-2.1.2'
  cmd_timeout 900
  action :build_if_missing
end
