#!/bin/bash

useradd heat-admin
echo "heat-admin:redhat" | chpasswd
echo "heat-admin ALL=(root) NOPASSWD:ALL" | tee -a /etc/sudoers.d/heat-admin
chmod 0440 /etc/sudoers.d/heat-admin
