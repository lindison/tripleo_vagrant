#!/usr/bin/env bash

# install MariaDB (https://mariadb.com/kb/en/mariadb/yum/)

touch /etc/yum.repos.d/MariaDB.repo

cat >> /etc/yum.repos.d/MariaDB.repo <<EOL
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/10.1/centos7-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOL

yum install -y MariaDB-server MariaDB-client
systemctl start mariadb
yum install -y epel-release
yum install -y MySQL-python

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile

