maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs Postgresql client and/or server"

supports 'ubuntu'

attribute "postgresql/db_name",
  :display_name => "Database name",
  :description => "PostgreSQL database name",
  :type => "string",
  :required => true,
  :default => "app"

attribute "postgresql/db_host",
  :display_name => "Database host",
  :description => "PostgreSQL database host address",
  :type => "string",
  :required => true,
  :default => "localhost"

attribute "postgresql/username",
  :display_name => "Database username",
  :description => "PostgreSQL database username",
  :type => "string",
  :required => true,
  :default => "app"

attribute "postgresql/password",
  :display_name => "Database password",
  :description => "PostgreSQL database password",
  :type => "string",
  :required => true,
  :default => "app"