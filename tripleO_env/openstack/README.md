### Installing OpenStack test machines using Vagrant and libvirt.

The vagrant files contained in this repo will build out a VM with the chosen version of OpenStack. 
A packstack answer file is included, to enabled or disable services update this file and run vagrant up. 
The default password is in the first few lines of the packstack answer file, if you remove the password, 
a random password will be selected and in the output of the install at the very end.  

To use: 

simply run `vagrant up`  

to login, `vagrant ssh`  

