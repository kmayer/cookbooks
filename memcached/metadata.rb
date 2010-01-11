maintainer        "Heavy Water Software, Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs memcached"

attribute "mememcached/memory_mb",
  :display_name => "Memcached Memory (MB)",
  :description => "Memcached Memory (MB)",
  :type => "string",
  :required => true,
  :default => "64"