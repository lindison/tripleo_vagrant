#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible

# copy examples into /home/vagrant (from inside the mgmt node)
cp -a /vagrant/* /home/vagrant
chown -R vagrant:vagrant /home/vagrant
mv id_rsa* /home/vagrant/.ssh/

# configure hosts file
cat >> /etc/hosts <<EOL

# ansible lab nodes
192.168.0.101 rdo01
192.168.0.102 rdo02
192.168.0.103 rdo03
192.168.0.104 rdo04
192.168.0.105 rdo05
192.168.0.106 rdo06

EOL

# configure known hosts file
touch /home/vagrant/.ssh/known_hosts
ssh-keyscan rdo01 rdo02 rdo03 rdo04 rdo05 rdo06 >> /home/vagrant/.ssh/known_hosts

# configure ansible default hosts file
cp /etc/ansible/hosts /etc/ansible/hosts.orig
rm /etc/ansible/hosts
cat >> /etc/ansible/hosts <<EOL

rdo01
rdo02
rdo03
rdo04
rdo05
rdo06

[openstack]
rdo01
rdo02
rdo03
rdo04
rdo05
rdo06

[openstack:vars]
ansible_ssh_user=vagrant
ansible_ssh_pass=vagrant
EOL

# install ssh keys
ansible-playbook ssh-addkey.yml
