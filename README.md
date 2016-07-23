# Vagrant build for an OpenStack environment
1. Use this Vagrantfile
..* run the ```make_ssh_keys.sh``` program to create a set of id_rsa keys for use by Ansible.
2. Simple run ```vagrant up```, the following will get built: 
* ooo01
* rdo01
* compute01
* maria01
* ansible01

-Once up, log into the ansible01 server ```vagrant ssh ansbile01``` and run the ```ssh_setup.sh``` program.  

- This assumes a single undercloud machine
- an overcloud machines
- a compute nodes
- An Ansible server

## This is a work in progress
- As mentioned, a work in progress
- Vagrantfile uses some bootstrp files (common, bash, ooo, ansible, maria, and rdo). 
- If you would like to customize the install, comment out the approproate boot strap in the Vagrantfile.
- Run the associated playbook from Ansible.

### Ansible
- The certs and the relationship between Ansible and the machine still needs to be done. 

## Additional Notes
- ubuntu_host folder contains a run script to install and configure vagrant for libvirt
- If you want to set libvirt as the default;
- ```export VAGRANT_DEFAULT_PROVIDER=libvirt```
- Vagrant start files for libvirt are located in libvirt directory

