#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
yum update
yum install -y vim

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant

