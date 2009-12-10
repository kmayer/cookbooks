node[:developers][:usernames].each do |username|
  user "#{username}" do
    home "/home/#{username}"
    shell "/bin/bash"
  end

  %W( /home/#{username} /home/#{username}/.ssh ).each do |d|
    directory d do
      owner "#{username}"
      group "#{username}"
      mode 0755
      action :create
    end
  end
  
  remote_file "/home/#{username}/.ssh/authorized_keys" do
    source "http://hw-public.s3.amazonaws.com/keys/#{username}.pub"
    owner "#{username}"
    group "#{username}"
    mode 0644
  end
end

group "sudo" do
  members node[:developers][:usernames]
end

group "www-data" do
  members node[:developers][:usernames]
end