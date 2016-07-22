#!/usr/bin/env bash

yum update 
yum install vim tree -y
apt-get update
apt-get install vim tree -y

# install ansible (http://docs.ansible.com/intro_installation.html)

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant
