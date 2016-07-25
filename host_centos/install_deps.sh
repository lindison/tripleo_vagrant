#!/bin/bash
# Install depedencies for Vagrant and lib-virt Vagrant plugin.
# Built on host Centos7

wget https://releases.hashicorp.com/vagrant/1.8.4/vagrant_1.8.4_x86_64.rpm
yum localinstall vagrant_1.8.4_x86_64.rpm
sudo yum update
yum install libxslt-devel libxml2-devel libvirt-devel libguestfs-tools-c ruby-devel
sudo alternatives --set ld /usr/bin/ld.gold
vagrant plugin install vagrant-libvirt
export VAGRANT_DEFAULT_PROVIDER=libvirt
