db_name = node[:postgresql][:db_name]
username = node[:postgresql][:username]
password = node[:postgresql][:password]


execute "create #{username} database user" do
  command "createuser --no-createdb --no-createrole --no-superuser #{username} && \
    psql --command \"alter role #{username} with encrypted password '#{password}'\""
  user "postgres"
  not_if do 
    `sudo -u postgres psql --tuples-only --command=" \
      select rolname from pg_roles where \
      rolname = '#{username}'"`.strip == "#{username}"
  end 
end

execute "create #{db_name} database" do
  command "createdb --owner=#{username} #{db_name}"
  user "postgres"
  not_if do 
    `sudo -u postgres psql --tuples-only --command=" \
      select datname from pg_database where \
      datname = '#{db_name}'"`.strip == "#{db_name}"
  end  
end