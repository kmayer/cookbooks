include_recipe "xtradb::default"

db_name = node[:xtradb][:db_name]
username = node[:xtradb][:username]
password = node[:xtradb][:password]
host = node[:xtradb][:host]

execute "create #{username} database user" do
  command %Q( mysql --execute="create user '#{username}'@'#{host}'
          identified by '#{password}';
          grant all on #{db_name}.* to '#{username}'@'%';
          flush privileges" )
  not_if "mysql --silent --skip-column-names --database=mysql \
        --execute=\"select User from user where \
        User = '#{username}'\" | grep #{username}"
end

execute "create #{db_name} database" do
  command "mysql --execute=\"create database #{db_name} character set utf8\""
  not_if "mysql --silent --skip-column-names \
      --execute=\"show databases like '#{db_name}'\" | grep #{db_name}" 
end