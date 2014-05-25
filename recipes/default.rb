#
# Cookbook Name:: riak-cs-prepare
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

user_ulimit "riak" do
  filehandle_limit node['riak_cs']['limits']['nofile']
end

#
# copied from riak-cs/recipe/default.rb
#
version_str = "#{node['riak_cs']['package']['version']['major']}.#{node['riak_cs']['package']['version']['minor']}.#{node['riak_cs']['package']['version']['incremental']}"
base_filename = "riak-cs-#{version_str}"

case node['riak_cs']['package']['type']
  when "binary"
    case node['platform']
    when "ubuntu"
      machines = {"x86_64" => "amd64", "i386" => "i386", "i686" => "i386"}
      package_file = "#{base_filename.gsub(/\-/, '_').sub(/_/,'-')}-#{node['riak_cs']['package']['version']['build']}_#{machines[node['kernel']['machine']]}.deb"
    when "debian"
      machines = {"x86_64" => "amd64", "i386" => "i386", "i686" => "i386"}
      package_file = "#{base_filename.gsub(/\-/, '_').sub(/_/,'-')}-#{node['riak_cs']['package']['version']['build']}_#{machines[node['kernel']['machine']]}.deb"
    when "redhat", "centos", "scientific", "amazon"
      machines = {"x86_64" => "x86_64", "i386" => "i386", "i686" => "i686"}
      package_file = "#{base_filename}-#{node['riak_cs']['package']['version']['build']}.el#{node['platform_version'].to_i}.#{machines[node['kernel']['machine']]}.rpm"
    when "fedora"
      machines = {"x86_64" => "x86_64", "i386" => "i386", "i686" => "i686"}
      package_file = "#{base_filename}-#{node['riak_cs']['package']['version']['build']}.fc#{node['platform_version'].to_i}.#{node['kernel']['machine']}.rpm"
    end
  end

package_name = package_file.split("[-_]\d+\.").first

# define action (to hook it)
package package_name do
  action :nothing
end

service "riak" do
  subscribes :restart, resources("package[#{package_name}]"), :immediately
end
