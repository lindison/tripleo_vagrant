#! /bin/bash

openstack overcloud deploy --templates --validation-errors-fatal --validation-warnings-fatal \
          -e /home/stack/templates/userdata_env.yaml \
          -e /home/stack/templates/lab-network-environment.yaml \
          -e /home/stack/templates/timezone.yaml \
          -t 120 \
          --control-flavor control \
          --compute-flavor compute \
          --control-scale 3 \
          --compute-scale 5 \
          --ceph-storage-scale 0 \
          --swift-storage-scale 0 \
          --block-storage-scale 0 \
          --ntp-server 24.56.178.140

