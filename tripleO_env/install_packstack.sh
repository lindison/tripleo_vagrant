#!/bin/bash
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network
sudo yum update
sudo yum install -y centos-release-openstack-liberty
sudo yum update -y
sudo yum install -y openstack-packstack
packstack --allinone
