# OpenStack Logging locations

## OpenStack

### Configure Logging Options

Each OpenStack service's configuration for logging can be tuned independently of other services.  
`/etc/<service_name>/<service_name>.conf`  

To enable verbose logging; set the following in the .conf file. NOTE: This will make logs larger.  
`debug=True`  

To enable verbose logging; set the following in the .conf file. NOTE: This will make logs larger.  
`verbose=True`  

To change the default log location; the following can be updated.  
`log_dir=/var/log/nova`  

Update the following to send the logs to a centralized log server.  
`use_syslog=True`
`syslog_log_facility=LOG_USER`

## Log File Locations

### Ironic Log Files

Name | Service | Log Location
--- | --- | ---
OpenStack Ironic API | openstack-ironic-api.service | /var/log/ironic/ironic-api.log  
OpenStack Ironic Conductor | openstack-ironic-conductor.service  | /var/log/ironic/ironic-conductor.log  

### Keystone Log Files
Name | Service | Log Location
--- | --- | ---
OpenStack Identity Service | openstack-keystone.service | /var/log/keystone/keystone.log

### Glance Log Files
Name | Service | Log Location
--- | --- | ---
OpenStack Image Service API server |openstack-glance-api.service | /var/log/glance/api.log
OpenStack Image Service Registry server | openstack-glance-registry.service | /var/log/glance/registry.log

### Cinder Log Files
Name | Service | Log Location
--- | --- | ---
Block Storage API | openstack-cinder-api.service | /var/log/cinder/api.log
Block Storage Backup | openstack-cinder-backup.service | /var/log/cinder/backup.log
Informational messages | The cinder-manage command | /var/log/cinder/cinder-manage.log
Block Storage Scheduler | openstack-cinder-scheduler.service | /var/log/cinder/scheduler.log
Block Storage Volume | openstack-cinder-volume.service | /var/log/cinder/volume.log

### Nova Log Files
Name | Service | Log Location
--- | --- | ---
OpenStack Compute API service | openstack-nova-api.service | /var/log/nova/nova-api.log
OpenStack Compute certificate server | openstack-nova-cert.service | /var/log/nova/nova-cert.log
OpenStack Compute service | openstack-nova-compute.service | /var/log/nova/nova-compute.log
OpenStack Compute Conductor service | openstack-nova-conductor.service | /var/log/nova/nova-conductor.log
OpenStack Compute VNC console authentication server | openstack-nova-consoleauth.service | /var/log/nova/nova-consoleauth.log
Informational messages | nova-manage command | /var/log/nova/nova-manage.log
OpenStack Compute NoVNC Proxy service | openstack-nova-novncproxy.service | /var/log/nova/nova-novncproxy.log
OpenStack Compute Scheduler service | openstack-nova-scheduler.service | /var/log/nova/nova-scheduler.log

### Neutron Log Files
Name | Service | Log Location
--- | --- | ---
OpenStack Neutron DHCP Agent | neutron-dhcp-agent.service | /var/log/neutron/dhcp-agent.log
OpenStack Networking Layer 3 Agent | neutron-l3-agent.service | /var/log/neutron/l3-agent.log
Metadata agent service | neutron-metadata-agent.service | /var/log/neutron/metadata-agent.log
Metadata namespace proxy | n/a | /var/log/neutron/neutron-ns-metadata-proxy-UUID.log
Open vSwitch agent | neutron-openvswitch-agent.service | /var/log/neutron/openvswitch-agent.log
OpenStack Networking service | neutron-server.service | /var/log/neutron/server.log

### Open vSwitch Log Files

Name | Service | Log Location
--- | --- | ---
Virtual network switch (Open vSwitch) | openvswitch-nonetwork.service | /var/log/openvswitch/ovsdb-server.log
Virtual network switch (Open vSwitch) | openvswitch-nonetwork.service | /var/log/openvswitch/ovs-vswitchd.log

### Heat Log Files
Name | Service | Log Location
--- | --- | ---
OpenStack Heat API Service | openstack-heat-api.service | /var/log/heat/heat-api.log
Openstack Heat Engine Service | openstack-heat-engine.service | /var/log/heat/heat-engine.log
Orchestration service events | n/a | /var/log/heat/heat-manage.log

### Horizon Log Files
Name | Service | Log Location
--- | --- | ---
Log of certain user interactions | Dashboard interface | /var/log/horizon/horizon.log

### RabbitMQ Log Files
Name | Service | Log Location
--- | --- | ---
Message broker (RabbitMQ) | rabbitmq-server.service | /var/log/rabbitmq/rabbit@short_hostname.log
Message broker (RabbitMQ) | rabbitmq-server.service | /var/log/rabbitmq/rabbit@short_hostname-sasl.log

### MariaDB Log Files
Name | Service | Log Location
--- | --- | ---
Database server (MariaDB) | mariadb.service | /var/log/mariadb/mariadb.log

### MondgoDB Log Files
Name | Service | Log Location
--- | --- | ---
Document-oriented database (MongoDB) | mongod.service | /var/log/mongodb/mongodb.log

### Apache Web Server Log Files
Name | Log Location
--- | ---
All processed HTTP requests | /var/log/httpd/horizon_access.log
HTTP errors | /var/log/httpd/horizon_error.log
Admin-role API requests | /var/log/httpd/keystone_wsgi_admin_access.log
Admin-role API errors | /var/log/httpd/keystone_wsgi_admin_error.log
Member-role API requests | /var/log/httpd/keystone_wsgi_main_access.log
Member-role API errors | /var/log/httpd/keystone_wsgi_main_error.log
Outside Web Service errors | /var/log/httpd/default_error.log
