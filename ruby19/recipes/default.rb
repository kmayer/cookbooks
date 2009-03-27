#
# Cookbook Name:: ruby19
# Recipe:: default
#
# Copyright 2009, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

remote_file "ruby19" do
  path "/tmp/ruby19.tar.gz"
  source "http://hw-packages.s3.amazonaws.com/ruby-1.9.1-p0.tar.gz"
end

bash "untar-ruby19" do
user "root"
  code "(cd /tmp; tar zxvf /tmp/ruby19.tar.gz)"
end

bash "install-ruby19" do
user "root"
  cwd "/tmp/ruby-1.9*"
  code "(./configure; make; make install)"
end
