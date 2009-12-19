maintainer        "Heavy Water Software, Inc."
maintainer_email  "darrin@heavywater.ca"
license           "MIT"
description       "Installs jruby"

%w{ java ant git }.each do |d|
  depends d
end