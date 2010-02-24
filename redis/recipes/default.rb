version = node[:redis][:version]

user "redis" do
  action :create
end

template "/etc/init.d/redis-server" do
  source "init.sh.erb"
  owner "root"
  group "root"
  mode "755"
end

service "redis-server" do
  supports :restart => true
  action :enable
end

remote_file "/usr/src/redis-#{version}.tar.gz" do
  source "http://redis.googlecode.com/files/redis-#{version}.tar.gz"
  checksum node[:redis][:checksum]
end

execute "untar redis" do
  command "tar xzf redis-#{version}.tar.gz"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/redis-#{version}/README"
end

execute "make redis" do
  command "make"
  cwd "/usr/src/redis-#{version}"
  creates "/usr/src/redis-#{version}/redis-server"
end

execute "install redis-server" do
  command "cp /usr/src/redis-#{version}/redis-server /usr/bin/redis-server"
  creates "/usr/bin/redis-server"
end

execute "install redis-cli" do
  command "cp /usr/src/redis-#{version}/redis-cli /usr/bin/redis-cli"
  creates "/usr/bin/redis-cli"
end

file "/usr/bin/redis-server" do
  owner "redis"
  group "redis"
  mode "755"
end

file "/usr/bin/redis-server" do
  owner "redis"
  group "redis"
  mode "755"
end

directory "/etc/redis" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

directory "/var/lib/redis" do
  owner "redis"
  group "redis"
  mode "755"
  action :create
end

template "/etc/redis/redis.conf" do
  source "redis.conf.erb"
  owner "root"
  group "root"
  mode "644"
  notifies :restart, resources( :service => "redis-server" )
end