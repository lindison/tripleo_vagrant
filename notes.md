## This is the ending of the last build.

The following cert files already exist, use --rebuild to remove the existing files before regenerating:  
/etc/keystone/ssl/certs/ca.pem already exists  
/etc/keystone/ssl/private/signing_key.pem already exists  
/etc/keystone/ssl/certs/signing_cert.pem already exists  
Connection to 10.0.0.6 closed.  
Skipping "horizon" postconfig because it wasn't found in the endpoint map output  
Overcloud Endpoint: http://10.0.0.6:5000/v2.0  
Overcloud Deployed  


### Running the scale test
[stack@undercloud ~]$ `openstack overcloud deploy --templates --control-scale 1 --compute-scale 3 --neutron-tunnel-types vxlan --neutron-network-type vxlan`  

Deploying templates in the directory   /usr/share/openstack-tripleo-heat-templates  
2016-08-05 05:37:11 [overcloud]: UPDATE_IN_PROGRESS  Stack UPDATE started

### Testing scaling standalone controller to HA deployment
The following will test scaling on the environment. Does it make sense to build a 1 controller, 1 compute environment prior to scaling it up to a 3 controller, 4 compute environment?

[stack@undercloud ~]$ `openstack overcloud deploy --templates --control-scale 1 --compute-scale 2 --ntp-server pool.ntp.org --neutron-network-type vxlan --neutron-tunnel-types vxlan`  


Let's see what this does...
`openstack overcloud deploy --templates -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml -e ~/templates/network-environment.yaml --control-scale 1 --compute-scale 4 --ntp-server pool.ntp.org --neutron-network-type vxlan --neutron-tunnel-types vxlan --neutron-bridge-mappings datacentre:br-ex,floating:br-floating`


### Scale done
Stack overcloud UPDATE_COMPLETE  
Overcloud Endpoint: http://10.0.0.6:5000/v2.0  
Overcloud Deployed  
