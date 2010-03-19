gem_package node[:bundler][:legacy] ? "bundler08" : "bundler" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end