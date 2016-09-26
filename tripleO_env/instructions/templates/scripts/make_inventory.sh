#!/bin/bash


echo "source OpenStack credentials file"
source ~/stackrc

echo "get node names and IP addresses"
nova list | awk '$6 == "ACTIVE" {print $12,$4};' > /tmp/hosts_nodes
nova list | awk '$6 == "ACTIVE" {print $4};' > /tmp/ansible_nodes
nova list | awk '$6 == "ACTIVE" {print $12};' > /tmp/ips_nodes
nova list | awk '$6 == "ACTIVE" {print $4};' > /tmp/names_nodes
awk '{gsub("ctlplane=", "");print}' /tmp/ips_nodes > /tmp/ips

echo "update /etc/hosts file"
cat /home/stack/hosts.orig > /etc/hosts
awk '{gsub("ctlplane=", "");print}' /tmp/hosts_nodes > /tmp/hostnames
cat /tmp/hostnames >> /etc/hosts

echo "registed ssh fingerprints to ssh known_hosts" 

rm /home/stack/.ssh/known_hosts
echo "10.0.0.4" >> /tmp/ips
echo "rsyslog" >> /tmp/names_nodes
for i in $(cat /tmp/ips); do ssh-keyscan $i >> /home/stack/.ssh/known_hosts; done
for i in $(cat /tmp/names_nodes); do ssh-keyscan $i >> /home/stack/.ssh/known_hosts; done
chown stack:stack /home/stack/.ssh/known_hosts

echo "create ansible hosts file"

echo "[rsyslog]" > /etc/ansible/hosts
echo "rsyslog" >> /etc/ansible/hosts
echo "[compute]" >> /etc/ansible/hosts
cat /tmp/ansible_nodes | grep compute >> /etc/ansible/hosts
echo "[control]" >> /etc/ansible/hosts
cat /tmp/ansible_nodes | grep control >> /etc/ansible/hosts
echo "[ceph]" >> /etc/ansible/hosts
cat /tmp/ansible_nodes | grep ceph >> /etc/ansible/hosts

echo "ANSIBLE ALL PING TEST"
su stack -s /bin/bash -c 'ansible all -m ping -u heat-admin'
echo "ANSIBLE CEPH PING TEST"
su stack -s /bin/bash -c 'ansible ceph -m ping -u heat-admin'
echo "ANSIBLE COMPUTE PING TEST"
su stack -s /bin/bash -c 'ansible compute -m ping -u heat-admin'
echo "ANSIBLE CONTROL PING TEST"
su stack -s /bin/bash -c 'ansible control -m ping -u heat-admin'
echo "ANSIBLE RSYSLOG PING TEST"
su stack -s /bin/bash -c 'ansible rsyslog -m ping -u heat-admin'
