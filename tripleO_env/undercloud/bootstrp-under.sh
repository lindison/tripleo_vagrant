#!/usr/bin/env bash

# Update the contents of the undercloud.conf

cp /home/vagrant/sync/build_undercloud.sh /home/vagrant
chown vagrant:vagrant /home/vagrant/build_undercloud.sh
cp /home/vagrant/sync/undercloud.conf /home/vagrant/undercloud.conf
chown vagrant:vagrant /home/vagrant/undercloud.conf

# Create pass for sshpass

