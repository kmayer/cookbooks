gem_package "rake" do
  path = node[:rvm][:gem_binary]
  gem_binary path if path
  action :upgrade
end

link "/usr/bin/rake" do
  to "/var/lib/gems/1.8/bin/rake"
  only_if "test -f /var/lib/gems/1.8/bin/rake"
end