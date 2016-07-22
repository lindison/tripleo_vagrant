#!/usr/bin/env bash

sudo yum -y install epel-release
sudo curl -L -o /etc/yum.repos.d/delorean.repo http://buildlogs.centos.org/centos/7/cloud/x86_64/rdo-trunk-master-tripleo/delorean.repo
sudo curl -L -o /etc/yum.repos.d/delorean-deps.repo http://trunk.rdoproject.org/centos7/delorean-deps.repo
sudo curl -L -o /etc/yum.repos.d/delorean-current.repo http://trunk.rdoproject.org/centos7/current/delorean.repo
sudo yum -y install yum-plugin-priorities
sudo yum install -y python-tripleoclient
cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
export DIB_INSTALLTYPE_puppet_modules=source
openssl genrsa -out privkey.pem 2048
openssl req \
    -new \
    -x509 \
    -key privkey.pem \
    -days 365 \
    -subj "/C=US/ST=Virginia/L=Springfield/O=Dis/CN=triple0.oooo2" \
    -out cacert.pem

cat cacert.pem privkey.pem > undercloud.pem
sudo mkdir /etc/pki/instack-certs
sudo cp undercloud.pem /etc/pki/instack-certs
sudo semanage fcontext -a -t etc_t "/etc/pki/instack-certs(/.*)?"
sudo restorecon -R /etc/pki/instack-certs
sudo cp cacert.pem /etc/pki/ca-trust/source/anchors/
sudo update-ca-trust extract
runuser -l vagrant -c "openstack undercloud install"

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
