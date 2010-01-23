include_recipe "git"
include_recipe "www-data"
include_recipe "nodejs"
include_recipe "nginx::nodejs"

execute "clone express" do
  command "git clone git://github.com/visionmedia/express.git current"
  cwd "/var/www"
  creates "/var/www/current/Readme.md"
  user "www-data"
end

execute "clone express submodules" do
  command "git submodule update --init"
  cwd "/var/www/current"
  creates "/var/www/current/lib/support/haml/README.markdown"
  user "www-data"
end

=begin

to start an example app:

  cd /var/www/current && node examples/chat/app.js &

=end