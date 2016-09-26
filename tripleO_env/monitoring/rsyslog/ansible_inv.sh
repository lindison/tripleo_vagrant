#!/bin/bash

source ~/stackrc
nova list | awk '$6 == "ACTIVE" {print $12,$4};' > /tmp/hosts_nodes
nova list | awk '$6 == "ACTIVE" {print $4,$12};' > /tmp/ansible_nodes
nova list | awk '$6 == "ACTIVE" {print $12};' > /tmp/ips_nodes
nova list | awk '$6 == "ACTIVE" {print $4};' > /tmp/names_nodes
awk '{gsub("ctlplane=", "");print}' /tmp/ips_nodes > /tmp/ips
cat /home/stack/hosts.orig > /etc/hosts
cat /tmp/hostnames >> /etc/hosts
rm /home/stack/.ssh/known_hosts
for i in $(cat /tmp/ips); do ssh-keyscan $i >> /home/stack/.ssh/known_hosts; done
for i in $(cat /tmp/names_nodes); do ssh-keyscan $i >> /home/stack/.ssh/known_hosts; done
chown stack:stack /home/stack/.ssh/known_hosts
awk '{gsub("ctlplane=", "");print}' /tmp/hosts_nodes > /tmp/hostnames
mv /tmp/ansible_nodes /etc/ansible/hosts
