# Vagrant build for an OpenStack environment
Holding, working with RH installer. 

## Used Vagrant Plugins

https://github.com/vagrant-libvirt
https://github.com/sciurus/vagrant-mutate
https://github.com/jedi4ever/sahara

## Working items
0. Working on PXE boot
  * PXE is generally working but need to get undercloud stable
  * need to figure out if this is doable using libvirt
  * resolved mapping local networks
  * resolved nested
  * put each deployment into its own folder for now
 
## Using this project (This is a work in progress).
1. Use these Vagrantfiles
  * update the Vagrant files in each of the folders to fit your needs
  * Define the "undercloud.conf.example" to fit your needs.
  * Vagrant file builds the following networks:
    * 10.0.0.0/23
    * 10.0.2.0/23 
    * 10.0.4.0/23
    * 10.0.6.0/23
    * 10.0.10.0/23
    * USES network 10.1.2.0/24 for PXE boots on a host bridge named "br-pxe"
  * ./build_undercloud.sh builds the undercloud server. 

## This is a work in progress
- As mentioned, a work in progress
- Vagrantfile uses some bootstrp files (common, bash, ooo, ansible, maria, and rdo). 
- If you would like to customize the install, comment out the approproate boot strap in the Vagrantfile.
- Run the associated playbook from Ansible.

### Ansible
- The certs and the relationship between Ansible and the machine still needs to be done. 

## Additional Notes
- Vagrant libvirt plugin: https://github.com/vagrant-libvirt/vagrant-libvirt
- ubuntu_host folder contains a run script to install and configure vagrant for libvirt
- If you want to set libvirt as the default;
- ```export VAGRANT_DEFAULT_PROVIDER=libvirt```
- Vagrant start files for libvirt are located in libvirt directory

