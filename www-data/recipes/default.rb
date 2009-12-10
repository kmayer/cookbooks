dirs = %w{/var/www /var/www/.ssh /var/www/releases /var/www/shared}
dirs = dirs + %w{/var/www/shared/system /var/www/shared/log /var/www/shared/pids}
dirs.each do |d|
  directory d do
    owner "www-data"
    group "www-data"
    mode 0755
    action :create
  end
end

node[:developers][:usernames].each do |username|
  execute "add #{username} key to www-data" do
    command "cat /home/#{username}/.ssh/authorized_keys >> /var/www/.ssh/authorized_keys"
    not_if "grep -f /home/#{username}/.ssh/authorized_keys /var/www/.ssh/authorized_keys"
    action :run
  end
end

file "/var/www/.ssh/authorized_keys" do
  owner "www-data"
  group "www-data"
  mode 0644
end