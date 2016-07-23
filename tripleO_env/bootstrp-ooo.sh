#!/usr/bin/env bash

cp /home/vagrant/sync/build_cloud.sh /home/vagrant
chown vagrant:vagrant /home/vagrant/build_cloud.sh

#yum -y install epel-release
#curl -L -o /etc/yum.repos.d/delorean.repo http://buildlogs.centos.org/centos/7/cloud/x86_64/rdo-trunk-master-tripleo/delorean.repo
#curl -L -o /etc/yum.repos.d/delorean-deps.repo http://trunk.rdoproject.org/centos7/delorean-deps.repo
#curl -L -o /etc/yum.repos.d/delorean-current.repo http://trunk.rdoproject.org/centos7/current/delorean.repo
#yum -y install yum-plugin-priorities
#yum install -y python-tripleoclient
#cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
#export DIB_INSTALLTYPE_puppet_modules=source
#openssl genrsa -out privkey.pem 2048
#openssl req \
#    -new \
#    -x509 \
#    -key privkey.pem \
#    -days 365 \
#    -subj "/C=US/ST=Virginia/L=Springfield/O=Dis/CN=triple0.oooo2" \
#    -out cacert.pem

#cat cacert.pem privkey.pem > undercloud.pem
#mkdir /etc/pki/instack-certs
#cp undercloud.pem /etc/pki/instack-certs
#semanage fcontext -a -t etc_t "/etc/pki/instack-certs(/.*)?"
#restorecon -R /etc/pki/instack-certs
#cp cacert.pem /etc/pki/ca-trust/source/anchors/
#update-ca-trust extract
#touch /home/vagrant/run_install.sh
#echo "openstack undercloud install" > /home/vagrant/run_install.sh
#chown vagrant:vagrant /home/vagrant/notes
#chmod +x /home/vagrant/run_install.sh

# yum update
# yum install -y vim tree
# yum install -y yum-utils
# yum-config-manager --enable rhelosp-rhel-7-server-opt
# yum -y install epel-release
# curl -L -o /etc/yum.repos.d/delorean.repo http://buildlogs.centos.org/centos/7/cloud/x86_64/rdo-trunk-master-tripleo/delorean.repo
# curl -L -o /etc/yum.repos.d/delorean-liberty.repo https://trunk.rdoproject.org/centos7-liberty/current/delorean.repo
# yum -y install yum-plugin-priorities
# yum install -y python-tripleoclient

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant
