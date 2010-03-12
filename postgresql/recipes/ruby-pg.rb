package "libpq-dev" do
  action :upgrade
end

gem_package "pg" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end