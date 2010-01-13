set_unless[:hyperic][:version] = "4.2.0"
set_unless[:hyperic][:server] = "localhost"
set_unless[:hyperic][:login] = "hqadmin"
set_unless[:hyperic][:password] = "hqadmin"
set_unless[:hyperic][:ip] = `/sbin/ifconfig eth0 | grep "inet addr" | cut -d: -f2 | awk '{print $1}'`.strip

set_unless[:hyperic][:agent_home] = "/home/hyperic/hyperic-hq-agent"
set_unless[:hyperic][:agent_uri] = "http://downloads.sourceforge.net/project/hyperic-hq/Hyperic%20HQ%204.2/HQ%204.2.0/hyperic-hq-agent-4.2.0-1260-noJRE.tgz"
set_unless[:hyperic][:agent_checksum] = "9b55c58a"

set_unless[:hyperic][:server_uri] = "http://downloads.sourceforge.net/project/hyperic-hq/Hyperic%20HQ%204.2/HQ%204.2.0/hyperic-hq-installer-4.2.0-1260-noJRE.tgz"
set_unless[:hyperic][:server_checksum] = "ae665549"
set_unless[:hyperic][:server_install_path] = "/home/hyperic/hyperic-hq-installer"

=begin

set_unless[:postgresql][:db_name] = 'HQ'
set_unless[:postgresql][:username] = 'admin'
set_unless[:postgresql][:password] = 'hqadmin'

{ 
  "recipes": [  "hyperic::server" ],
  "postgresql": { 
    "db_name":  "HQ", 
    "username": "admin", 
    "password": "hqadmin" 
  }
}

=end