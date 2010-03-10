include_recipe "www-data"
include_recipe "ruby-enterprise-edition"
include_recipe "unicorn"

gem_package "rack" do
  version "1.0.1"
  action :install
end

gem_package "rails" do
  action :upgrade
end