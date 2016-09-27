# Using openstack-config to set logging for rsyslog

`openstack-config --set /etc/nova/nova.conf DEFAULT rpc_response_timeout 600`  
`openstack-config --set /etc/ironic/ironic.conf DEFAULT rpc_response_timeout 600`  

#On controllers

## Configure rsyslog.d/client.conf


cat << EOF > /etc/rsyslog.d/client.conf
*.* @10.0.0.4:514
EOF

## Configure OpenStack conf files

openstack-config --set /etc/nova/nova.conf DEFAULT debug false  
openstack-config --set /etc/nova/nova.conf DEFAULT use_syslog true  
openstack-config --set /etc/nova/nova.conf DEFAULT syslog_log_facility LOG_LOCAL0  

openstack-config --set /etc/keystone/keystone.conf DEFAULT debug false  
openstack-config --set /etc/keystone/keystone.conf DEFAULT use_syslog true  
openstack-config --set /etc/keystone/keystone.conf DEFAULT syslog_log_facility LOG_LOCAL1  

openstack-config --set /etc/glance/glance-api.conf DEFAULT debug false  
openstack-config --set /etc/glance/glance-api.conf DEFAULT use_syslog true  
openstack-config --set /etc/glance/nglance-api.conf DEFAULT syslog_log_facility LOG_LOCAL2  

openstack-config --set /etc/glance/glance-registry.conf DEFAULT debug false  
openstack-config --set /etc/glance/glance-registry.conf DEFAULT use_syslog true  
openstack-config --set /etc/glance/glance-registry.conf DEFAULT syslog_log_facility LOG_LOCAL3  

openstack-config --set /etc/cinder/cinder.conf DEFAULT debug false  
openstack-config --set /etc/cinder/cinder.conf DEFAULT use_syslog true  
openstack-config --set /etc/cinder/cinder.conf DEFAULT syslog_log_facility LOG_LOCAL4  

## Configure MySQL logs

# Restart services
systemctl restart openstack-nova-api  
systemctl restart openstack-nova-cert
systemctl restart openstack-nova-consoleauth
systemctl restart openstack-nova-scheduler
systemctl restart openstack-nova-conductor
systemctl restart openstack-nova-novncproxy  
systemctl restart openstack-cinder-*
systemctl restart openstack-glance-*
systemctl restart openstack-keystone*
systemctl restart rsyslog.service
