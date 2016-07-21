#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile
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
