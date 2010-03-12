include_recipe "www-data"
include_recipe "ruby-enterprise-edition"
include_recipe "unicorn"

gem_package "rack" do
  version "1.0.1"
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :install
end

gem_package "rails" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end