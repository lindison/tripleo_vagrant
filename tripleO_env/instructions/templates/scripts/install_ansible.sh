#!/bin/bash

yum install wget -y  
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm  
sudo rpm -Uvh epel-release-latest-7*.rpm  
yum install -y python-pip  
pip install ansible
mkdir /etc/ansible/ 
