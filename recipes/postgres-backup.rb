#
# Cookbook Name:: chef-docker-happiness
# Recipe:: postgres-backup
#

require 'date'
include_recipe 'docker'

remote_directory '/tmp/postgres-backup' do
  source 'postgres-backup'
end

docker_image 'austenito/postgres-backup' do
  source '/tmp/postgres-backup'
  tag Date.today.to_date.to_s
  action :build
  cmd_timeout 1600
end
