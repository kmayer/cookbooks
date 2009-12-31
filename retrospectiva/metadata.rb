maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs Retrospectiva"

supports 'ubuntu'

attribute "postgresql/db_name",
  :display_name => "Database name",
  :description => "Retrospectiva database name",
  :type => "string",
  :required => true,
  :default => "retrospectiva"

attribute "postgresql/username",
  :display_name => "Database username",
  :description => "Retrospectiva database username",
  :type => "string",
  :required => true,
  :default => "retrospectiva"

attribute "postgresql/password",
  :display_name => "Database password",
  :description => "Retrospectiva database password",
  :type => "string",
  :required => true,
  :default => "retrospectiva"