maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs monit"

supports 'ubuntu'

attribute "monit/email",
  :display_name => "Email",
  :description => "Email address where monit alerts are sent",
  :type => "string",
  :default => "darrin@heavywater.ca"

attribute "monit/servers",
  :display_name => "Servers",
  :description => "Number of server processes",
  :type => "string",
  :default => "5"

attribute "monit/start_port",
  :display_name => "Start port",
  :description => "The first port to which server process will bind",
  :type => "string",
  :default => "5000"