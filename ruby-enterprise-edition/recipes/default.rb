remote_file "/usr/src/#{node[:ree][:deb]}" do
  source node[:ree][:project_url]
  checksum node[:ree][:checksum]
end

execute "ruby-enterprise" do
  command "dpkg -i /usr/src/#{node[:ree][:deb]}"
  not_if do `ruby --version`.include? "Ruby Enterprise Edition" end
end