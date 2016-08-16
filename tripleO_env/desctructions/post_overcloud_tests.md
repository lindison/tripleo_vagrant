##Post OverCloud install

register machine to redhat subscription
`yum install -y wget`  
`mkdir /tmp/images`  
`wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img`  
`glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img   --disk-format qcow2 --container-format bare --visibility public --progress`  
`glance image-list`  
`nova image-list`  
`ssh-keygen -q -N ""`  
`nova keypair-add --pub-key ~/.ssh/id_rsa.pub demo-key`  
`for i in {1..10}; do nova boot --flavor m1.tiny --image cirros-0.3.3-x86_64 --security-group default --key-name demo-key demo-instance$i; done`  

[heat-admin@overcloud-controller-0 ~]$ nova list
+--------------------------------------+-----------------+--------+------------+-------------+----------+
| ID                                   | Name            | Status | Task State | Power State | Networks |
+--------------------------------------+-----------------+--------+------------+-------------+----------+
| 0ac16b13-003b-437b-94e6-c7f72b0a686d | demo-instance1  | ACTIVE | -          | Running     |          |
| 4db4262b-9acd-4189-97fa-ae364200e323 | demo-instance10 | BUILD  | spawning   | NOSTATE     |          |
| a2efd437-1b96-4a94-bfed-a899e2ad1652 | demo-instance2  | ACTIVE | -          | Running     |          |
| 84ccac59-b2b7-4490-888a-afd30d5d278b | demo-instance3  | ACTIVE | -          | Running     |          |
| 0d42329a-d913-410b-84fa-ba1861bd0229 | demo-instance4  | ACTIVE | -          | Running     |          |
| fca65c38-ba78-48be-ae08-b04ef9bc5647 | demo-instance5  | ACTIVE | -          | Running     |          |
| 579bbd01-7c92-4689-8410-cfa678eb3a71 | demo-instance6  | ACTIVE | -          | Running     |          |
| 7ddea225-3779-455f-b4de-dbe21d7981f1 | demo-instance7  | ACTIVE | -          | Running     |          |
| af6a32f8-f2a8-4479-8d83-7ceda932476e | demo-instance8  | ACTIVE | -          | Running     |          |
| 617a8d57-67d4-471c-8155-b6a2da903614 | demo-instance9  | ACTIVE | -          | Running     |          |
+--------------------------------------+-----------------+--------+------------+-------------+----------+
[heat-admin@overcloud-controller-0 ~]$ for i in {1..10}; do nova delete demo-instance$i; done
[heat-admin@overcloud-controller-0 ~]$ nova list
+----+------+--------+------------+-------------+----------+
| ID | Name | Status | Task State | Power State | Networks |
+----+------+--------+------------+-------------+----------+
+----+------+--------+------------+-------------+----------+

+--------------------------------------+-----------+-------+------+-----------+-------+-----------+
| ID                                   | Name      |   RAM | Disk | Ephemeral | VCPUs | Is Public |
+--------------------------------------+-----------+-------+------+-----------+-------+-----------+
| 0b408f91-0eea-4cf9-9032-e646603ec1e7 | mega-8-64 | 65536 |   40 |         0 |     8 | True      |
| 337ea328-6ff4-45d8-9c72-867042e15386 | kilo-2-40 | 40960 |   40 |         0 |     2 | True      |
| 3d5bfc0d-03a8-48dc-92c1-8e15b24781b2 | mega-2-16 | 16384 |   40 |         0 |     2 | True      |
| 6becb8d7-14f1-47fe-b6ae-326bb462c4a8 | mega-4-16 | 16384 |   40 |         0 |     4 | True      |
| 741d1304-2717-429d-a2f3-d94ac27e273f | mega-4-32 | 32768 |   40 |         0 |     4 | True      |
| 8945c0bc-1841-40f7-8e14-9f1f386b0ae1 | kilo-1-20 | 20480 |   40 |         0 |     1 | True      |
| b0d8d110-2369-4009-aa44-021429394ba6 | kilo-2-80 | 81920 |   40 |         0 |     2 | True      |
| cd20b188-d7c8-4877-8d53-3f0846056437 | kilo-1-40 | 40960 |   40 |         0 |     1 | True      |
| e8fa6fa2-49fb-49ea-b7ef-a50fccd58aab | mega-8-32 | 32768 |   40 |         0 |     8 | True      |
+--------------------------------------+-----------+-------+------+-----------+-------+-----------+
