include_recipe 'docker'

if `sudo docker ps -a | grep console,`.size > 0
  execute('stop container') { command "docker stop -t 60 hs-console" }
  execute('remove container') { command "docker rm -f hs-console" }
end

docker_container 'hs-console' do
  image 'austenito/happiness-service'
  container_name "hs-console"
  env ["LOGENTRIES_HAPPINESS_SERVICE_TOKEN=#{node['logentries']['happiness_service']}"]
  link ['postgres:db']
  volumes_from 'happiness-data'
  action :run
  detach true
  tty true
  stdin true
  command "/bin/bash"
end

docker_container 'hs-console' do
  action :stop
end
