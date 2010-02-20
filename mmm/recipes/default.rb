# borrowed liberally from 37s_cookbooks

include_recipe "perl"

version = node[:mmm][:version]

perl_modules = %w( Algorithm::Diff Class::Singleton
  DBI DBD::mysql File::Basename File::stat File::Temp
  Log::Dispatch Log::Log4perl Mail::Send Net::Ping
  Net::ARP Proc::Daemon Thread::Queue Time::HiRes )
  
perl_modules.each do |mod|
    cpan_module mod
end

remote_file "/usr/src/mysql-mmm-#{version}.tar.gz" do
  source "http://mysql-mmm.org/_media/:mmm2:mysql-mmm-#{version}.tar.gz"
  checksum "05a9127a"
end

execute "untar mysql-mmm" do
  command "tar xzf mysql-mmm-#{version}.tar.gz"
  creates "/usr/src/mysql-mmm-#{version}/README"
  cwd "/usr/src"
end

execute "install mysql-mmm" do
  command "make install"
  cwd "/usr/src/mysql-mmm-#{version}"
  creates "/usr/sbin/mmmd_agent"
end

%w( mmm_agent mmm_common mmm_mon mmm_tools ).each do |file|
  template "/etc/mysql-mmm/#{file}.conf" do
    source "#{file}.conf.erb"
    owner "root"
    group "root"
    mode "0640"
  end  
end