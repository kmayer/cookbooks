maintainer        "Heavy Water Software Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Add developers"

supports 'ubuntu'

attribute "developers/usernames",
  :display_name => "Developer usernames",
  :description => "A list of developer usernames to create",
  :type => "array",
  :required => true,
  :default => "dje"

attribute "developers/keys_uri",
  :display_name => "URI with public ssh keys",
  :description => "The URI where public ssh keys are downloadable",
  :type => "string",
  :required => true,
  :default => "http://hw-public.s3.amazonaws.com/keys/"  