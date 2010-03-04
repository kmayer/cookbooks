version = node[:rubygems][:version]

remote_file "/usr/src/rubygems-#{version}.tgz" do
  source "http://production.cf.rubygems.org/rubygems/rubygems-#{version}.tgz"
  checksum node[:rubygems][:checksum]
  owner "root"
  group "root"
end

execute "untar rubygems" do
  command "tar xzf rubygems-#{version}.tgz"
  user "root"
  creates "/usr/src/rubygems-#{version}/README"
  cwd "/usr/src"
end

execute "install rubygems" do
  command "ruby setup.rb"
  creates "/usr/bin/gem1.9.1"
  cwd "/usr/src/rubygems-#{version}"
end

link "/usr/bin/gem" do
  to "/usr/bin/gem1.9.1"
end