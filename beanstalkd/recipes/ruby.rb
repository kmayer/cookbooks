include_recipe "beanstalkd"

gem_package "beanstalk-client" do
  action :upgrade
end