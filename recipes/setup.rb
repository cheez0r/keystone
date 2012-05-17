#
# Cookbook Name:: keystone
# Recipe:: setup

setup_commands = node[:keystone][:setup_commands]
if setup_commands then
  setup_commands.each do |cmd|
    execute "/usr/bin/keystone-manage #{cmd}" do
      user 'keystone'
      not_if { File.exists?("/var/lib/keystone/setup") }
    end
  end
end

execute "touch /var/lib/keystone/setup"
