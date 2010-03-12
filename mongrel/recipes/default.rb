%w( mongrel mongrel_cluster ).each do |g|
  gem_package g do
    path = node[:rvm][:gem_binary]
    gem_binary path if path
    action :upgrade
  end
end

link "/usr/bin/mongrel_rails" do
  to "/usr/local/bin/mongrel_rails"
  only_if "test -f /usr/local/bin/mongrel_rails"
end