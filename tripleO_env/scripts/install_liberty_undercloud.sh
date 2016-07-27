sudo yum update -y
sudo yum install -y vim tree
sudo systemctl disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable NetworkManager
sudo systemctl stop NetworkManager
sudo systemctl enable network
sudo systemctl start network
sudo yum -y install epel-release

# sudo curl -L -o /etc/yum.repos.d/delorean.repo http://buildlogs.centos.org/centos/7/cloud/x86_64/rdo-trunk-master-tripleo/delorean.repo
# sudo curl -L -o /etc/yum.repos.d/delorean-deps.repo http://trunk.rdoproject.org/centos7/delorean-deps.repo
# sudo curl -L -o /etc/yum.repos.d/delorean-current.repo http://trunk.rdoproject.org/centos7/current/delorean.repo

# sudo curl -L -o /etc/yum.repos.d/delorean-current.repo http://trunk.rdoproject.org/centos7/current/delorean.repo
# sudo sed -i 's/\[delorean\]/\[delorean-current\]/' /etc/yum.repos.d/delorean-current.repo
# sudo curl -L -o /etc/yum.repos.d/delorean-deps.repo http://trunk.rdoproject.org/centos7/delorean-deps.repo

sudo curl -L -o /etc/yum.repos.d/delorean-liberty.repo https://trunk.rdoproject.org/centos7-liberty/current/delorean.repo
sudo curl -L -o /etc/yum.repos.d/delorean-deps-liberty.repo http://trunk.rdoproject.org/centos7-liberty/delorean-deps.repo

sudo yum -y install yum-plugin-priorities
sudo yum install -y python-tripleoclient
sudo cp /usr/share/instack-undercloud/undercloud.conf.sample ~/undercloud.conf
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
openstack undercloud install

export USE_DELOREAN_TRUNK=1
export DELOREAN_TRUNK_REPO="http://buildlogs.centos.org/centos/7/cloud/x86_64/rdo-trunk-master-tripleo/"
export DELOREAN_REPO_FILE="delorean.repo"

openstack overcloud image build --all
openstack overcloud image upload
