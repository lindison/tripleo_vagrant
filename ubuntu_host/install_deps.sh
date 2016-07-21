#!/bin/bash
# Install depedencies for Vagrant and lib-virt Vagrant plugin.
# Built on host Ubuntu 16.04

wget https://releases.hashicorp.com/vagrant/1.8.5/vagrant_1.8.5_x86_64.deb
sudo dpkg -i vagrant_1.8.5_x86_64.deb
sud apt-get update
sudo apt-get install -y libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev ruby-libvirt
vagrant plugin install vagrant-libvirt
