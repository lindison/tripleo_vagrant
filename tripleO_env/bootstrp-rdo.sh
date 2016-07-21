#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
yum update
yum install -y vim tree
systemctl disable firewalld
systemctl stop firewalld
systemctl disable NetworkManager
systemctl stop NetworkManager
systemctl enable network
systemctl start network
yum update
yum install -y centos-release-openstack-mitaka
yum update -y
yum install -y openstack-packstack
packstack --allinone


# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant
