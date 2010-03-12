gem_package "rack" do
  version "1.0.1"
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :install
end