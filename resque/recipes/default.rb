include_recipe "redis"

%w( resque yajl-ruby thin ).each do |g|
  gem_package g do
    path = node[:rvm][:gem_binary]
    gem_binary path if path
    action :upgrade
  end
end

link "/usr/bin/resque-web" do
  to "/var/lib/gems/1.8/bin/resque-web"
  only_if "test -f /var/lib/gems/1.8/bin/resque-web"
end