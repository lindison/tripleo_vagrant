# Using a KVM host as the lab server.

Credit to Keith Tenzer for the work he's done on running OpenStack Director in KVM with a KVM hosted OverCloud. 

## My lab config

My config uses two Ubuntu 16.04 LTS servers.  

Box one, 8 CPUs, 72GB RAM, 256 x 2 RAID0 SSD  
Box two, 8 CPUs, 32GB RAM, 256 x 2 RAID0 SSD, 512 x 5 RAID0 HDD  
Three routable networks between the boxes.  
10.0.0.0/24 - PXE Network (00-PXE)  
192.168.10.0/24 - Storage Network (40-STORAGE)  
192.168.1.0/24 - Management (20-MGMT)  

4TB Synology NAS for LDAP, SSO, and iSCSI services  

## Configure the OpenStack Undercloud

A few updates will need to be done on the undercloud system to work with a KVM hosted overcloud deployment.

### increase timeout values on undercloud (for virtual pxe_ssh only)

On the undercloud server, configure the following:

`sudo su -`  
`openstack-config --set /etc/nova/nova.conf DEFAULT rpc_response_timeout 600`  
`openstack-config --set /etc/ironic/ironic.conf DEFAULT rpc_response_timeout 600`  
`openstack-service restart nova`  
`openstack-service restart ironic`  
`exit`

### Create the networks.

I create the networks using virt-manager and the GUI it provides.

| Network        | Subnet           | NAT  |
| ------------- |:-------------:| -----:|
| 00-PXE      | 10.0.0.0/24 | NO |
| 20-MGMT      | 10.0.2.0/24       |   NO |
| 40-STORAGE | 10.0.4.0/24       |    NO |
| 60-TENANT      | 10.0.6.0/24  | NO |
| 80-ILO      | 10.0.8.0/24       |   NO |
| 90-PUBLIC | 10.0.10.0/24       |    YES |

You can also use an xml file to build the networks
`virsh net-define /tmp/provisioning.xml`  
`virsh net-autostart provisioning`  
`virsh net-start provisioning`  

### Create PXE Machine

The machines are created with the following settings.  
The network for each is configured as such:

| Name        | Setting           |
| ------------- |:-------------:|
| hostname      | pxe01 |
| CPU      | 4 vCPU      |   
| RAM | 8096MB      |   
| DISK      | 100GB |
| NIC1      | 00-PXE |
| NIC2      | 20-MGMT      |  
| NIC3      | 40-STORAGE |
| NIC4      | 60-TENANT      |   
| NIC5      | 90-PUBLIC |



### Enable access on KVM to Ironic (run as root)

On the KVM Server, configure KVM to work with Ironic.

`cat << EOF > /etc/polkit-1/localauthority/50-local.d/50-libvirt-user-stack.pkla
[libvirt Management Access]
Identity=unix-user:stack
Action=org.libvirt.unix.manage
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF`

### From the undercloud node, configure ssh login (using ssh key)

`ssh-copy-id stack@<KVM host IP>`

### Get mac addresses for interfaces (top MAC is one needed)
There are several ways to get the mac addresses; the next step is an easy way but if the output of OSP changes, it'll no longer work. Another way is to copy it from the virt-manager; lastly, a dumpxml from virsh outputs the mac address as well.

### To Watson (compute node host)
for i in {1..8}; do virsh -c qemu+ssh://root@192.168.1.128/system domiflist pxe0$i | awk '$3 == "br-pxe" {print $5};'; done > /tmp/nodes.txt && cat /tmp/nodes.txt

### To jingles (ceph node host)
for i in {10..13}; do virsh -c qemu+ssh://root@192.168.1.119/system domiflist pxe$i | awk '$3 == "br-pxe" {print $5};'; done > /tmp/cephnodes.txt && cat /tmp/cephnodes.txt


### Create the json (refer to create_json_kvm doc)
Using the file called "instack_json_kvm.md" as a starting point, update the template to fit the number of machines you are working with. Once completed, cut and paste the content from jq . to EOF into the undercloud console.

### Validate the json

Pull down the instackenv validator.   
`curl -O https://raw.githubusercontent.com/rthallisey/clapper/master/instackenv-validator.py`  

Run the instackenv validator against the json just created.   
`python instackenv-validator.py -f instackenv.json`  

### Add nodes to Ironic  
Upon validating the json file, import the nodes into Ironic on the undercloud server.

`openstack baremetal import --json instackenv.json`  
`openstack baremetal import --json instackenvceph.json`  

### Show nodes registered
`ironic node-list`  
`ironic node-show`  

### A Python program for the bootif-fix
The next component is to update the undercloud machine to work with PXE ssh. there are a couple ways to do this.

### Use a python program written by Mohammed Salih.
https://github.com/linusali/osp-tools

### Configure undercloud to use pxe-ssh
Use the shell script written by Kieth Tenzer.

`sudo su -
cat << EOF > /usr/bin/bootif-fix
#!/usr/bin/env bash

while true;
        do find /httpboot/ -type f ! -iname "kernel" ! -iname "ramdisk" ! -iname "*.kernel" ! -iname "*.ramdisk" -exec sed -i 's|{mac|{net0/mac|g' {} +;
done
EOF`

### Change Permissions of executable file
`chmod a+x /usr/bin/bootif-fix`


### Create bootif-fix service
`cat << EOF > /usr/lib/systemd/system/bootif-fix.service
[Unit]
Description=Automated fix for incorrect iPXE BOOFIF

[Service]
Type=simple
ExecStart=/usr/bin/bootif-fix

[Install]
WantedBy=multi-user.target
EOF`

### Restart services
`systemctl daemon-reload`  
`systemctl enable bootif-fix`  
`systemctl start bootif-fix`  
`exit`  

### Create kvm-baremetal flavor
`openstack flavor create --id auto --ram 8192 --disk 58 --vcpus 1 kvm-baremetal`
`openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" kvm-baremetal`
