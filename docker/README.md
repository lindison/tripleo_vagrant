# Docker


## Installing Docker on one of the UnderCloud servers  

Update RedHat packages  
`sudo yum update`  

Install the Docker Repository  
`sudo tee /etc/yum.repos.d/docker.repo <<-EOF  
[dockerrepo]  
name=Docker Repository  
baseurl=https://yum.dockerproject.org/repo/main/centos/7  
enabled=1  
gpgcheck=1  
gpgkey=https://yum.dockerproject.org/gpg  
EOF`  

Install the Docker Engine  
`sudo yum install docker-engine`  

Add stack user to Docker Group  
`sudo gpasswd -a ${USER} docker`

Start the Docker daemon  
`sudo service docker start`  

Verify `docker` is installed correctly by running a test image in a container  
`docker run hello-world`  
