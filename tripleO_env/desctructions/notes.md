## This is the ending of the last build.

>The following cert files already exist, use --rebuild to remove the existing files before regenerating:
/etc/keystone/ssl/certs/ca.pem already exists
/etc/keystone/ssl/private/signing_key.pem already exists
/etc/keystone/ssl/certs/signing_cert.pem already exists
Connection to 10.0.0.6 closed.
Skipping "horizon" postconfig because it wasn't found in the endpoint map output
Overcloud Endpoint: http://10.0.0.6:5000/v2.0
Overcloud Deployed


### Running the scale test
[stack@undercloud ~]$ ```openstack overcloud deploy --templates --control-scale 1 --compute-scale 3 --neutron-tunnel-types vxlan --neutron-network-type vxlan```
- Deploying templates in the directory /usr/share/openstack-tripleo-heat-templates
- 2016-08-05 05:37:11 [overcloud]: UPDATE_IN_PROGRESS  Stack UPDATE started

### Testing scaling standalone controller to HA deployment
```openstack overcloud deploy --templates --control-scale 3 --compute-scale 3 --ceph-storage-scale 3 --ntp-server pool.ntp.org --neutron-network-type vxlan --neutron-tunnel-types vxlan```


### Scale done
> Stack overcloud UPDATE_COMPLETE
Overcloud Endpoint: http://10.0.0.6:5000/v2.0
Overcloud Deployed

### Flavors:
>command:

- Kilo-1-20, 1vCPU, 20GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 20480 0 1 --rxtx-factor .1 ```
- Kilo-1-40, 1vCPU, 40GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 40960 0 1 --rxtx-factor .1 ```
- Kilo-2-40, 2vCPU, 40GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 40960 0 2 --rxtx-factor .1 ```
- Kilo-2-80, 2vCPU, 80GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 81920 0 2 --rxtx-factor .1 ```
- Mega-2-16, 2vCPU, 16GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 16384 0 2 --rxtx-factor .1 ```
- Mega-4-16, 4vCPU, 16GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 16384 0 4 --rxtx-factor .1 ```
- Mega-4-32, 4vCPU, 32GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 32768 0 4 --rxtx-factor .1 ```
- Mega-8-32, 8vCPU, 32GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 32768 0 8 --rxtx-factor .1 ```
- Mega-8-64, 8vCPU, 64GB RAM
- ```openstack flavor create --is-public true kilo-1-20 auto 65536 0 8 --rxtx-factor .1 ```

### OS (assume 64bit on all):
 http://docs.openstack.org/image-guide/obtain-images.html link for images
- Red Hat Enterprise Linux 6 (x86_64)
- ```https://rhn.redhat.com/rhn/software/channel/downloads/Download.do?cid=16952```
- Red Hat Enterprise Linux 7 (x86_64)
- ```https://access.redhat.com/downloads/content/69/ver=/rhel---7/x86_64/product-downloads```
- Ubuntu LTS 14.04 (x86_64)
- ```http://cloud-images.ubuntu.com/trusty/```
- CentOS 6 (x86_64)
- ```http://cloud.centos.org/centos/6/images/```
- CentOS 7 (x86_64)
- ```http://cloud.centos.org/centos/7/images/```
- Windows Server 2012 R2 (x86_64)
- ```https://cloudbase.it/windows-cloud-images/```
- OEL (x86_64)
- ```
