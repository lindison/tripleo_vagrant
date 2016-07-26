#!/bin/bash

for i in $(virsh list --all --name); do virsh suspend $i; done
