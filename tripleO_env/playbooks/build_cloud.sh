#!/bin/bash

openstack undercloud install
ansible-playbook prepare_undercloud.yml
openstack overcloud image build --all



