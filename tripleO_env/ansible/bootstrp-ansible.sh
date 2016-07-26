#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)
apt-get -y install software-properties-common
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get -y install ansible
apt-get -y install tree

# copy playbooks into /home/vagrant (from inside the mgmt node)
mkdir /home/vagrant/playbooks
cp -a /vagrant/playbooks/* /home/vagrant/playbooks
# cp -a /vagrant/m* /home/vagrant
chown -R vagrant:vagrant /home/vagrant

# sets up ssh keys
cp /vagrant/id_rsa /home/vagrant/.ssh/
cp /vagrant/id_rsa.pub /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa
chown vagrant:vagrant /home/vagrant/.ssh/id_rsa.pub

# Create names file for ssh-keyscan and ssh-copy-id
# Put server names in here for use with Ansible
#cp /vagrant/names /home/vagrant/names
#chown vagrant:vagrant /home/vagrant/names
#touch /home/vagrant/names

# Create pass for sshpass
#cat >> /home/vagrant/pass.txt <<EOL
#vagrant
#EOL
#chown vagrant:vagrant /home/vagrant/pass.txt
#cp /vagrant/ssh_setup.sh /home/vagrant/ssh_setup.sh
#chown vagrant:vagrant /home/vagrant/ssh_setup.sh
#chmod +x /home/vagrant/ssh_setup.sh
#runuser -l vagrant -c "/home/vagrant/ssh_setup.sh"

# runuser -l vagrant -c "ssh-keyscan $(cat /home/vagrant/names) >> /home/vagrant/.ssh/known_hosts"
# runuser -l vagrant -c "for i in $(cat /home/vagrant/names); do sshpass -f pass.txt ssh-copy-id vagrant@$(cat /home/vagrant/names); done"
# runuser -l vagrant -c "for i in $(cat /home/vagrant/names); do sshpass -f pass.txt ssh-copy-id vagrant@$(cat /home/vagrant/names); done"

# Configure Ansible Hosts file, update with hosts names for each component.
cat >> /etc/ansible/hosts <<EOL

[undercloud]
ooo01
ooo02
ooo03

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
