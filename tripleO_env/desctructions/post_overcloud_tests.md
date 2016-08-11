##Post OverCloud install

register machine to redhat subscription
yum install -y wget
mkdir /tmp/images
wget -P /tmp/images http://download.cirros-cloud.net/0.3.3/cirros-0.3.3-x86_64-disk.img
glance image-create --name "cirros-0.3.3-x86_64" --file /tmp/images/cirros-0.3.3-x86_64-disk.img   --disk-format qcow2 --container-format bare --visibility public --progress
glance image-list
nova image-list
for i in {1..10}; do nova boot --flavor m1.tiny --image cirros-0.3.3-x86_64 --security-group default --key-name demo-key demo-instance$i; done

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
