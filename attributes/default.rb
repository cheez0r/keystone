default[:keystone][:config_file] = "/etc/keystone/keystone.conf"
default[:keystone][:log_config] = "/etc/keystone/logging.cnf"
default[:keystone][:db_file] = "/var/lib/keystone/keystone.db"

default[:keystone][:verbose] = "True"
default[:keystone][:debug] = "False"
default[:keystone][:default_store] = "sqlite"
default[:keystone][:sql_connection] = "sqlite:////var/lib/keystone/keystone.db"
default[:keystone][:sql_idle_timeout] = "30"
default[:keystone][:log_file] = "/var/log/keystone/keystone.log"
default[:keystone][:service_protocol] = "http"
default[:keystone][:service_host] = "0.0.0.0"
default[:keystone][:service_port] = "5000"
default[:keystone][:admin_protocol] = "http"
default[:keystone][:admin_host] = "0.0.0.0"
default[:keystone][:admin_port] = "35357"
default[:keystone][:admin_role] = "Admin"
default[:keystone][:service_admin_role] = "KeystoneServiceAdmin"
default[:keystone][:sql_idle_timeout] = "3600"

default[:keystone][:hash_password] = "True"
default[:keystone][:service_ssl] = "False"
default[:keystone][:admin_ssl] = "False"
default[:keystone][:certfile] = "/etc/keystone/ssl/certs/keystone.pem"
default[:keystone][:keyfile] = "/etc/keystone/ssl/private/keystonekey.pem"
default[:keystone][:ca_certs] = "/etc/keystone/ssl/certs/ca.pem"
default[:keystone][:cert_required] = "True"

default[:keystone][:sql_connection] = "sqlite:////var/lib/keystone/keystone.sqlite"

#default setup commands for keystone::setup recipe
default[:keystone][:setup_commands] = [
"tenant add 'admin'",
"user add admin AABBCC112233 admin",
"service add nova compute",
"service add glance image",
"role add Admin nova",
"role add Member nova",
"role grant Admin admin admin",
"role grant Admin admin",
"endpointTemplates add RegionOne nova http://nova1:8774/v1.1/%tenant_id% http://nova1:8774/v1.1/%tenant_id% http://nova1:8774/v1.1/%tenant_id% 1 1",
"endpointTemplates add RegionOne glance http://glance1:9292/v1 http://glance1:9292/v1 http://glance1:9292/v1 1 1",
"endpoint add admin 1",
"credentials add admin EC2 'admin:admin' admin admin",
"token add '999888777666' 'admin' 'admin' '2020-02-05T00:00'"
]

default[:keystone][:creds] = [
  {
  :os_user => "root",
  :auth_user => "admin",
  :auth_key => "AABBCC112233",
  :auth_tenant => "admin",
  :auth_url => "http://login:5000/v2.0/"
  }
]
