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

bash "install-ruby19" do
user "root"
  cwd "/tmp"
  code <<-EOH
  wget http://hw-packages.s3.amazonaws.com/ruby-1.9.1-p0.tar.gz
  tar -zxf ruby-1.9.1-p0.tar.gz
  cd ruby-1.9.1-p0
  ./configure
  make
  make install
  EOH
end
