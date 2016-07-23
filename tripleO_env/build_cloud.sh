#!/bin/bash

On-UnderCloud Node
openstack undercloud install
openstack overcloud image build --all
openstack overcloud image upload



