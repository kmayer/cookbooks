include_recipe "postgresql::client"

package "postgresql" do
  action :upgrade
end