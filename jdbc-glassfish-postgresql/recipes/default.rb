include_recipe "glassfish"

remote_file "/opt/glassfishv3/glassfish/domains/domain1/lib/postgresql-8.4-701.jdbc4.jar" do
  source "http://jdbc.postgresql.org/download/postgresql-8.4-701.jdbc4.jar"
  checksum "c9d2f577"
  owner "glassfish"
  group "glassfish"
  mode 0644
  notifies :restart, resources(:service => "glassfish")
end