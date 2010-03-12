include_recipe "git"

%w( curl zlib1g-dev ).each do |g|
  package g do
    action :upgrade
  end
end

user "rvm" do
  home "/home/rvm"
end

directory "/home/rvm" do
  owner "rvm"
  group "rvm"
  mode "755"
  action :create
end

template "/home/rvm/.bashrc" do
  source "bashrc.erb"
  mode "644"
  owner "rvm"
  group "rvm"
end

execute "clone rvm repository" do
  command "git clone git://github.com/wayneeseguin/rvm.git"
  user "rvm"
  group "rvm"
  creates "/home/rvm/rvm/README"
  cwd "/home/rvm"
end

execute "install rvm" do
  command "./install"
  user "rvm"
  group "rvm"
  creates "/home/rvm/.rvm/bin/rvm"
  cwd "/home/rvm/rvm"
  environment "HOME" => "/home/rvm"
end

version = node[:rvm][:default]
execute "install ruby #{version}" do
  command "./rvm install #{version}"
  user "rvm"
  group "rvm"
  cwd "/home/rvm/.rvm/bin"
  environment "HOME" => "/home/rvm"
  not_if "test -d /home/rvm/.rvm/rubies/*#{version}*"
end

execute "set default ruby to #{version} " do
  command "./rvm use #{version} --default"
  user "rvm"
  group "rvm"
  cwd "/home/rvm/.rvm/bin"
  environment "HOME" => "/home/rvm"
  not_if "readlink /home/rvm/.rvm/bin/default_ruby | grep #{version}"
end