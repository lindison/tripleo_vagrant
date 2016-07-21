#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get update
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial experimental" | sudo tee /etc/apt/sources.list.d/docker.list
apt-get update
apt-get install -y docker-engine
usermod -aG docker vagrant

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
