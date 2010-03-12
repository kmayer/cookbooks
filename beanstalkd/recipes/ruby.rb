include_recipe "beanstalkd"

gem_package "beanstalk-client" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end