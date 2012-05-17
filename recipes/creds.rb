#
# Cookbook Name:: keystone
# Recipe:: creds
#

node[:keystone][:creds].each do |data|
  creds = {
    :auth_user => data[:auth_user],
    :auth_key => data[:auth_key],
    :auth_tenant => data[:auth_tenant],
    :auth_url => data[:auth_url]
  }

  if data[:os_user] == 'root' then
    user_home=''
  else
    user_home='home'
  end

  rcfile = File.join(user_home, data[:os_user], "openstackrc")
  template rcfile do
    source "openstackrc.erb"
    owner data[:os_user]
    group "root"
    mode 0600
    variables :creds => creds
  end

  user_rcfile = File.join(user_home, data[:os_user], ".bashrc")
  execute "echo \"source #{rcfile}\" >> #{user_rcfile}" do
    user "root"
    not_if "grep openstackrc #{user_rcfile}"
  end

end
