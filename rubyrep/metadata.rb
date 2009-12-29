maintainer        "Heavy Water Software, Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs rubyrep"

supports 'ubuntu'

attribute "rubyrep/version",
  :display_name => "RubyRep version",
  :description => "RubyRep version",
  :type => "string",
  :required => true,
  :default => "1.1.0"

attribute "rubyrep/adapter",
  :display_name => "RubyRep adapter",
  :description => "RubyRep database adapter",
  :type => "string",
  :required => true,
  :default => "postgresql"
  
attribute "rubyrep/database_name",
  :display_name => "RubyRep database name",
  :description => "RubyRep database name",
  :type => "string",
  :required => true,
  :default => "database"
  
attribute "rubyrep/username",
  :display_name => "RubyRep username",
  :description => "RubyRep database username (assumes same)",
  :type => "string",
  :required => true,
  :default => "username"
    
attribute "rubyrep/password",
  :display_name => "RubyRep password",
  :description => "RubyRep database password (assumes same)",
  :type => "string",
  :required => true,
  :default => "password"

attribute "rubyrep/right_host",
  :display_name => "RubyRep right host",
  :description => "RubyRep address to the database known as the \"right\" host",
  :type => "string",
  :required => true,
  :default => "some_host.example.com"
  
attribute "rubyrep/left_host",
  :display_name => "RubyRep left host",
  :description => "RubyRep address to the database known as the \"left\" host",
  :type => "string",
  :required => true,
  :default => "another_host.example.com"