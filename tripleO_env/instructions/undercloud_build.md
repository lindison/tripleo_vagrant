# Start install of Undercloud

`echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf`
`hostnamectl set-hostname undercloud.local.com`
`hostnamectl set-hostname --transient undercloud.local.com`

#Update transient name to /etc/hosts file
`vi /etc/hosts`  (example: 127.0.0.1 undercloud.local.com)

`subscription-manager register`  

`subscription-manager subscribe --pool=8a85f98155e9947d0155ea71bc2b1389`  

`subscription-manager repos --disable=*`  

`subscription-manager repos --enable=rhel-7-server-rpms --enable=rhel-7-server-extras-rpms --enable=rhel-7-server-openstack-8-rpms --enable=rhel-7-server-openstack-8-director-rpms --enable rhel-7-server-rh-common-rpms`

`sudo yum install -y elinks`

`sudo yum update -y`

`sudo reboot`

`useradd stack`

`echo "stack:redhat" | chpasswd`

`echo "stack ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/stack`

`chmod 0440 /etc/sudoers.d/stack`

### Login as stack user
`su - stack`

`cd ~`

`mkdir images`

`mkdir templates`

`sudo yum install -y python-tripleoclient`

### Need to determine if this needs to be done to resolve the horizon issue.
`sudo yum downgrade python-tripleoclient-0.3.4-4.el7ost.noarch`

### Need to check this fix if needed with physicals
When the undercloud reboots; it may go into a emergancy boot state. This is the fix.

`https://access.redhat.com/solutions/1437183`

### Put customer specific config in here {{ undercloud.conf }}

`vi undercloud.conf`

### Install the undercloud

`openstack undercloud install`

### Validate undercloud is installed

This can be added to a typical bashrc file, if desired. Source the file to get the OpenStack credentials.

`source ~/stackrc`

This should show services running

`openstack-status`

This should show ...

`openstack catalog show nova`

## END UnderCloud Installed
---

### Prepare undercloud for deploying overcloud

`sudo yum -y install rhosp-director-images rhosp-director-images-ipa`

`cp /usr/share/rhosp-director-images/overcloud-full-latest-8.0.tar ~/images/.`

`cp /usr/share/rhosp-director-images/ironic-python-agent-latest-8.0.tar ~/images/.`

`cd ~/images`

`for tarfile in *.tar; do tar -xf $tarfile; done`

`openstack overcloud image upload --image-path /home/stack/images`

### Validate images are uploaded

`openstack image list`

### Check neutron dns

neutron subnet-list

### Need id

`neutron subnet-update $subnetid --dns-nameserver 10.0.0.1`

### Create the json (refer to create_json_kvm doc)
### instructions are in instack_json_kvm.txt

### Validate the json
`curl -O https://raw.githubusercontent.com/rthallisey/clapper/master/instackenv-validator.py`

`python instackenv-validator.py -f instackenv.json`

### Add nodes to Ironic

`openstack baremetal import --json instackenv.json`

### Show nodes registered

`ironic node-list`

### Create flavors (as needed)

### Delete original flavors
`for n in control compute ceph-storage; do  nova flavor-delete $n;  done`  

### Validate Flavors deleted
`nova flavor-list`  

### Create new flavors
`openstack flavor create --id auto --ram 2048 --disk 37 --vcpus 1 --swap 2048 control`  
`openstack flavor create --id auto --ram 2048 --disk 37 --vcpus 1 --swap 2048 compute`  
`openstack flavor create --id auto --ram 2048 --disk 37 --vcpus 1 --swap 2048 ceph-storage`  

### Assign flavors to profiles
`openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" --property "capabilities:profile"="control" control`  
`openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" --property "capabilities:profile"="compute" compute`  
`openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" --property "capabilities:profile"="ceph-storage" ceph-storage`  

`openstack baremetal configure boot`

`openstack baremetal introspection bulk start`

### Setup CEPH nodes

https://access.redhat.com/documentation/en/red-hat-openstack-platform/8/paged/red-hat-ceph-storage-for-the-overcloud/chapter-2-creating-an-overcloud-with-ceph-storage-nodes


### Manually adding profiles to a node.

`ironic node-update $ctl01 add properties/capabilities='profile:control,boot_option:local'`  
`ironic node-update $ctl02 add properties/capabilities='profile:control,boot_option:local'`  
`ironic node-update $ctl03 add properties/capabilities='profile:control,boot_option:local'`  
`ironic node-update $nova01 add properties/capabilities='profile:compute,boot_option:local'`  
`ironic node-update $ceph01 add properties/capabilities='profile:ceph-storage,boot_option:local'`  

### Validate profiles were assigned.

`openstack overcloud profiles list`  

### Configure yml files:
- `vi templates/network-environment.yaml`
- `vi templates/nic-configs/controller.yaml`

`openstack overcloud deploy --templates -e ~/templates/ips-from-pool.yaml --control-scale 1 --compute-scale 1 --ntp-server pool.ntp.org --neutron-tunnel-types vxlan --neutron-network-type vxlan`

### Install OverCloud using user defined templates
`openstack overcloud deploy --templates -e /usr/share/openstack-tripleo-heat-templates/environments/network-isolation.yaml -e ~/templates/network-environment.yaml -e ~/templates/firstboot-environment.yaml --control-scale 1 --compute-scale 1 --control-flavor control --compute-flavor compute --ntp-server pool.ntp.org --neutron-network-type vxlan --neutron-tunnel-types vxlan`
