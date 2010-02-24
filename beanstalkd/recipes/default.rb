version = node[:beanstalkd][:version]

package "libevent-dev" do
  action :upgrade
end

user "beanstalkd" do
  action :create
end

template "/etc/default/beanstalkd" do
  source "beanstalkd.default.erb"
  owner "root"
  group "root"
  mode "644"
end

template "/etc/init.d/beanstalkd" do
  source "beanstalkd.init.erb"
  owner "root"
  group "root"
  mode "755"
end

service "beanstalkd" do
  supports :restart => true
  action :enable
end

remote_file "/usr/src/beanstalkd-#{version}.tar.gz" do
  source "http://xph.us/dist/beanstalkd/beanstalkd-#{version}.tar.gz"
  owner "root"
  group "root"
  checksum node[:beanstalkd][:checksum]
end

execute "untar beanstalkd" do
  command "tar xzf beanstalkd-#{version}.tar.gz"
  cwd "/usr/src"
  user "root"
  group "root"
  creates "/usr/src/beanstalkd-#{version}/README"
end

execute "configure beanstalkd" do
  command "./configure"
  user "root"
  group "root"
  cwd "/usr/src/beanstalkd-#{version}"
  creates "/usr/src/beanstalkd-#{version}/config.log"
end

execute "make beanstalkd" do
  command "make"
  user "root"
  group "root"
  cwd "/usr/src/beanstalkd-#{version}"
  creates "/usr/src/beanstalkd-#{version}/beanstalkd"
end

link "/usr/bin/beanstalkd" do
  to "/usr/local/bin/beanstalkd"
end

execute "install beanstalkd" do
  command "make install"
  cwd "/usr/src/beanstalkd-#{version}"
  creates "/usr/local/bin/beanstalkd"
  notifies :start, resources( :service => "beanstalkd" )
end