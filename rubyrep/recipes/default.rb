include_recipe "java"

%w( unzip gawk ).each do |p|
  package p do
    action :upgrade
  end
end

version = node[:rubyrep][:version]

remote_file "/tmp/rubyrep-#{version}.zip" do
  source "http://rubyforge.org/frs/download.php/67941/rubyrep-#{version}.zip"
  owner "root"
  group "root"
  mode "644"
  checksum "4f6af1df"
end

execute "unzip rubyrep" do
  command "unzip -qud /opt rubyrep-#{version}.zip"
  creates "/opt/rubyrep-#{version}/README.txt"
  cwd "/tmp"
  action :run
end

template "/opt/rubyrep-#{version}/replicate" do
  source "replicate.sh.erb"
  owner "root"
  group "root"
  mode "755"
end

link "/opt/rubyrep" do
  to "/opt/rubyrep-#{version}"
end

directory "/etc/rubyrep" do
  owner "root"
  group "root"
  mode "755"
  action :create
end

template "/etc/init.d/rubyrep" do
  source "init.sh.erb"
  mode "755"
  owner "root"
  group "root"
end

template "/etc/rubyrep/rubyrep.conf" do
  source "rubyrep.conf.erb"
  mode "644"
  owner "root"
  group "root"
  variables( 
    :adapter => node[:rubyrep][:adapter],
    :database_name => node[:rubyrep][:database_name],
    :username => node[:rubyrep][:username],
    :password => node[:rubyrep][:password],
    :right_host => node[:rubyrep][:right_host],
    :left_host => node[:rubyrep][:left_host])
end