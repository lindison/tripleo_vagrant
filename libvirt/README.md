# Vagrant files for libvirt

Sometimes you can get an error that looks like:  

Bringing machine 'tunirserver' up with 'libvirt' provider...
/usr/share/gems/gems/fog-1.23.0/lib/fog/libvirt/requests/compute/list_volumes.rb:32:in `info': Call to virStorageVolGetInfo failed: Storage volume not found: no storage vol with matching path '/tmp/orbit-kdas' (Libvirt::RetrieveError)  

When you get this error:

Run:  
`sudo virsh pool-list`  

and refresh the pools:  

`sudo virsh pool-refresh <pool_name>`


