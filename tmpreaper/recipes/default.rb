package "tmpreaper" do
  action :upgrade
end

template "/etc/tmpreaper.conf" do
  source "tmpreaper.conf.erb"
  owner "root"
  group "root"
  mode "644"
end