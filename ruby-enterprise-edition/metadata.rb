maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs Ruby Enterprise Edition"

supports 'ubuntu'

attribute "ree/deb",
  :display_name => "REE Debian package",
  :description => "The Debian package for Ruby Enterprise Edition",
  :type => "string",
  :required => true,
  :default => "ruby-enterprise_1.8.7-2009.10_i386.deb"
  
attribute "ree/project_url",
  :display_name => "REE package URL",
  :description => "REE package URL",
  :type => "string",
  :required => true,