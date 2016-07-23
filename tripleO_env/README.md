### Installing TripleO
1. Run ```vagrant up```
2. Log into ansible01 ```vagrant ssh ansible01```
3. Move to the playbooks directory and run ```ansible-playbook install_tripleO.yml```
4. Log into ooo01 ```vagrant ssh ooo01```
5. Run the install command: ```openstack undercloud install```

