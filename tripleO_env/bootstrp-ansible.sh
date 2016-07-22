#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible
apt-get -y install tree

# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/playbooks/* /home/vagrant/playbooks
# cp -a /vagrant/m* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# Configure Ansible Hosts file.

cat >> /etc/ansible/hosts <<EOL

[undercloud]
ooo01

[overcloud]
rdo01
rdo02

[occompute]
compute01
compute02

[mariadb]
maria01

[docker]
docker01

EOL
