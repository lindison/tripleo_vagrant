# increase timeout values on undercloud (for virtual pxe_ssh only)
sudo su -
openstack-config --set /etc/nova/nova.conf DEFAULT rpc_response_timeout 600
openstack-config --set /etc/ironic/ironic.conf DEFAULT rpc_response_timeout 600
openstack-service restart nova
openstack-service restart ironic
exit

virsh net-define /tmp/provisioning.xml
virsh net-autostart provisioning
virsh net-start provisioning

# Create PXE Machine
for i in {1..2}; do qemu-img create -f qcow2 -o preallocation=metadata overcloud-node$i.qcow2 60G; done
for i in {1..2}; do virt-install --ram 4096 --vcpus 4 --os-variant \
rhel7 --disk path=/home/lindis/VirtualMachines/overcloud-node$i.qcow2,device=disk,bus=virtio,format=qcow2 \
--noautoconsole --vnc --network network:80-ILO --network network:20-MGMT \
--network network:60-TENANT --network network:40-STORAGE --name overcloud-node$i \
--cpu SandyBridge,+vmx --dry-run --print-xml > /tmp/overcloud-node$i.xml; virsh define \
--file /tmp/overcloud-node$i.xml; done

#Enable access on KVM to Ironic (run as root)
cat << EOF > /etc/polkit-1/localauthority/50-local.d/50-libvirt-user-stack.pkla
[libvirt Management Access]
Identity=unix-user:stack
Action=org.libvirt.unix.manage
ResultAny=yes
ResultInactive=yes
ResultActive=yes
EOF

#From the undercloud node, configure ssh login (using ssh key)
ssh-copy-id stack@10.0.2.1

#Get mac addresses for interfaces (top MAC is one needed)
for i in {1..8}; do virsh -c qemu+ssh://root@192.168.1.128/system domiflist pxe0$i | awk '$3 == "00-PXE" {print $5};'; done > /tmp/nodes.txt && cat /tmp/nodes.txt

# Create the json (refer to create_json_kvm doc)

# Validate the json
curl -O https://raw.githubusercontent.com/rthallisey/clapper/master/instackenv-validator.py
python instackenv-validator.py -f instackenv.json

# Add nodes to Ironic
openstack baremetal import --json instackenv.json

# Show nodes registered
ironic node-list
ironic node-show

# Configure undercloud to use pxe-ssh
sudo su -
cat << EOF > /usr/bin/bootif-fix
#!/usr/bin/env bash

while true;
        do find /httpboot/ -type f ! -iname "kernel" ! -iname "ramdisk" ! -iname "*.kernel" ! -iname "*.ramdisk" -exec sed -i 's|{mac|{net0/mac|g' {} +;
done
EOF

chmod a+x /usr/bin/bootif-fix
cat << EOF > /usr/lib/systemd/system/bootif-fix.service
[Unit]
Description=Automated fix for incorrect iPXE BOOFIF

[Service]
Type=simple
ExecStart=/usr/bin/bootif-fix

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable bootif-fix
systemctl start bootif-fix
exit

# Create kvm-baremetal flavor
openstack flavor create --id auto --ram 8192 --disk 58 --vcpus 1 kvm-baremetal
openstack flavor set --property "cpu_arch"="x86_64" --property "capabilities:boot_option"="local" kvm-baremetal
