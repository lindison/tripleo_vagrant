#!/usr/bin/env bash

# Install some common tools

yum install epel-release -y
yum install policycoreutils-python -y
yum install rsyslog -y


# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant
