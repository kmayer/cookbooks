remote_file "/tmp/#{node[:ree][:deb]}" do
  source "#{node[:ree][:project_url]}"
  checksum "c6d1489b"
end

dpkg_package "ruby-enterprise" do
  source "/tmp/#{node[:ree][:deb]}"
  action :upgrade 
end