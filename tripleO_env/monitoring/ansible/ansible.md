# Ansible Install on RHEL using pip
yuho 
pip install shade  



wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/openstack.py  
chmod +x openstack.py  

ansible -i openstack.py all -m ping  
