include_recipe "git"

package "curl" do
  action :upgrade
end

version = node[:rvm][:default]

execute "clone rvm repository" do
  command "git clone git://github.com/wayneeseguin/rvm.git"
  user "root"
  group "root"
  creates "/usr/src/rvm/README"
  cwd "/usr/src"
end

execute "install rvm" do
  command "./install"
  user "root"
  group "root"
  creates "/usr/local/bin/rvm"
  cwd "/usr/src/rvm"
end

template "/etc/rvmrc" do
  source "rvmrc.erb"
  owner "root"
  group "root"
  mode "644"
end

execute "install ruby #{version}" do
  command "rvm install #{version}"
  user "root"
  group "root"
end

execute "set default ruby to #{version} " do
  command "rvm #{version } --default"
  user "root"
  group "root"
end