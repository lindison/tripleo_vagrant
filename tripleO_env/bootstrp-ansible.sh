#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible
apt-get -y install tree

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL

# ansible lab nodes
192.168.33.10  acs
192.168.33.20  lb1
192.168.33.31  dev1
192.168.33.32  dev2
192.168.33.21  web1
192.168.33.22  web2
192.168.33.23  web3
192.168.33.24  web4
192.168.33.25  web5
192.168.33.50  db1
EOL
