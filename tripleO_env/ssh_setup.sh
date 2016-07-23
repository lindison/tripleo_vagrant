#!/bin/bash

ssh-keyscan $(cat /home/vagrant/names) >> /home/vagrant/.ssh/known_hosts
for i in $(cat /home/vagrant/names); do sshpass -f pass.txt ssh-copy-id vagrant@$(cat /home/vagrant/names); done
