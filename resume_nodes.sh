#!/bin/bash

for i in $(virsh list --all --name); do virsh resume $i; done
