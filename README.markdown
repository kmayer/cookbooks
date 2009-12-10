# Heavy Water Cookbook

**WARNING: This cookbook destroys computers. Be sure to understand every line before running. Unexpected things will happen anyway.**

## Install Chef and build tools on Ubuntu 9.10 (Karmic)

    sudo apt-get install chef ohai ruby-full rubygems build-essential

## Select recipes

Edit /etc/chef/node.json with a list of recipes

    { "recipes": [ "developers", "sshd" ] }

## Running recipes

    sudo chef-solo --log_level info --json-attributes /etc/chef/node.json \
      --recipe-url http://hw-public.s3.amazonaws.com/cookbooks.tgz