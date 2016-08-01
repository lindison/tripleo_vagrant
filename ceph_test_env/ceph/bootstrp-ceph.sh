#!/usr/bin/env bash

useradd -d /home/ceph -m ceph
echo "ceph:redhat" | chpasswd
echo "ceph ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ceph
chmod 0440 /etc/sudoers.d/ceph
yum update -y
yum install -y vim tree
yum install -y epel-release
systemctl stop firewalld
systemctl disable firewalld
#firewall-cmd --zone=public --add-port=6800-7300/tcp --permanent
#firewall-cmd --zone=public --add-port=22/tcp --permanent
#firewall-cmd --zone=public --add-port=80/tcp --permanent
#firewall-cmd --zone=public --add-port=2003/tcp --permanent
#firewall-cmd --zone=public --add-port=4505-4506/tcp --permanent
#firewall-cmd --reload
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant
