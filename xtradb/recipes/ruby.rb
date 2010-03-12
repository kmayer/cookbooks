package "libmysqlclient-dev" do
  options "--force-yes"
  action :upgrade
end

gem_package "mysql" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end