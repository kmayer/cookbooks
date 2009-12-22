include_recipe "git"
include_recipe "www-data"
include_recipe "nginx::unicorn"
include_recipe "postgresql::server"

execute "clone retrospectiva" do
  command "git clone git://github.com/dim/retrospectiva.git /var/www/current"
end