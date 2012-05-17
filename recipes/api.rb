#
# Cookbook Name:: keystone
# Recipe:: api
#
#

user "keystone" do
  shell "/bin/bash"
end

group "keystone" do
  members ["keystone"]
end

directory File.dirname(node[:keystone][:config_file]) do
  owner "keystone"
  group "keystone"
  mode "0755"
  action :create
end

directory File.dirname(node[:keystone][:db_file]) do
  owner "keystone"
  group "keystone"
  mode "0755"
  action :create
end

directory File.dirname(node[:keystone][:log_config]) do
  owner "keystone"
  group "keystone"
  mode "0755"
  action :create
end

template node[:keystone][:config_file] do
  source "keystone.conf.erb"
  owner "keystone"
  group "keystone"
  mode 0644
end

template node[:keystone][:log_config] do
  source "logging.cnf.erb"
  owner "keystone"
  group "keystone"
  mode 0644
end

package "keystone" do
  options "--force-yes -o Dpkg::Options::=\"--force-confdef\""
  action :install
end

keystone_svc_name="keystone"
service keystone_svc_name do
  if (platform?("ubuntu") && node.platform_version.to_f >= 10.04)
    restart_command "restart #{keystone_svc_name}"
    stop_command "stop #{keystone_svc_name}"
    start_command "start #{keystone_svc_name}"
    status_command "status #{keystone_svc_name} | cut -d' ' -f2 | cut -d'/' -f1 | grep start"
  end
  supports :status => true, :restart => true
  action :start
  subscribes :restart, resources(:template => node[:keystone][:config_file])
end
