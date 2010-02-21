package "libmysqlclient-dev" do
  options "--force-yes"
  action :upgrade
end

gem_package "mysql" do
  action :upgrade
end