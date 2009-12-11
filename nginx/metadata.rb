maintainer        'Heavy Water Software, Inc.'
maintainer_email  'darrin@heavywater.ca'
license           'MIT'
description       'Compiles and installs nginx over the packaged version for security'

supports 'ubuntu', '= 9.10'

attribute 'nginx/version',
  :display_name => 'Nginx version',
  :description => 'Nginx version to compile and install',
  :type => 'string',
  :required => true,
  :default => '0.7.64'