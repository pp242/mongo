#
# Cookbook:: mongodb-server
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.


# template '/tmp/mongodb_installer' do
# 	source 'http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.2 multiverse'
# 	action :create
# end

apt_repository 'mongodb-org' do
  keyserver  'hkp://keyserver.ubuntu.com:80'
  uri 'http://repo.mongodb.org/apt/ubuntu' 
  key 'EA312927'
  distribution 'xenial/mongodb-org/3.2'
  components ['multiverse']
end

apt_update

package 'mongodb-org'

service 'mongod' do
	supports status: true, restart: true, reload: true
	action [:enable, :start]
end


template '/etc/systemd/system/mongod.service' do
  source 'mongod.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
end	

template '/etc/mongod.conf' do
  source 'mongod.conf.erb'
  owner 'root'
  group 'root'
  mode '0755'
end	



