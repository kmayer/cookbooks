maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs a collection of frontend processes"

supports 'ubuntu'

attribute 'frontend/ssl',
  :display_name => 'SSL nginx',
  :description => 'Include an SSL capable nginx service',
  :type => 'string',
  :required => true,
  :default => 'false'