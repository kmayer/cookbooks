package "openjdk-6-jdk" do
  action :upgrade
end

execute "set JAVA_HOME" do
  command "echo JAVA_HOME=/usr >> /etc/environment"
  not_if "grep JAVA_HOME /etc/environment"
end