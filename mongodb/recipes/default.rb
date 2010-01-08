include_recipe "git"
include_recipe "spidermonkey"

packages = %w(tcsh scons g++ libpcre++-dev 
  libboost-dev libreadline-dev xulrunner-dev
  libboost-program-options-dev libboost-thread-dev
  libboost-filesystem-dev libboost-date-time-dev)

packages.each do |p|
  package p do
    action :install
  end
end

user "mongodb" do
  comment "MongoDB User"
  home "/home/mongodb"
end

directory "/home/mongodb" do
  owner "mongodb"
  group "mongodb"
  mode "755"
  action :create
end

version = node[:mongodb][:version]

remote_file "/home/mongodb/mongodb-src-r#{version}.tar.gz" do
  source "http://downloads.mongodb.org/src/mongodb-src-r#{version}.tar.gz"
  checksum node[:mongodb][:checksum]
end

execute "untar mongodb-src-r#{version}" do
  command "tar -xzf mongodb-src-r#{version}.tar.gz"
  creates "/home/mongodb/mongodb-src-r#{version}"
  cwd "/home/mongodb"
  action :run
end

execute "build mongodb" do
  command "scons all"
  cwd "/home/mongodb/mongodb-src-r#{version}"
  creates "/usr/bin/mongo"
  action :run
end

execute "install mongodb" do
  command "scons --prefix=/opt/mongo install"
  cwd "/home/mongodb/mongodb-src-r#{version}"
  creates "/usr/bin/mongo"
  action :run
end

link "/usr/bin/mongo" do
  to "/opt/mongo/bin/mongo"
end

link "/usr/bin/mongod" do
  to "/opt/mongo/bin/mongod"
end

directory "/etc/mongo" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/etc/mongo/mongo.conf" do
  source "mongo.conf.erb"
  mode "644"
  owner "root"
  group "root"
end

template "/etc/init/mongo.conf" do
  source "mongo_upstart.conf.erb"
  mode "644"
  owner "root"
  group "root"
end

execute "start mongodb" do
  command "start mongo"
  action :run
end

=begin

service "mongodb" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

=end