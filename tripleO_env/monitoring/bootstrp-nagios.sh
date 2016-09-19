#!/usr/bin/env bash

# install ansible (http://docs.ansible.com/intro_installation.html)

# copy examples into /home/vagrant (from inside the mgmt node)
# cp -a /vagrant/examples/* /home/vagrant/.examples
# cp -a /vagrant/m* /home/vagrant
# chown -R vagrant:vagrant /home/vagrant

# configure hosts file for our internal network defined by Vagrantfile

yum install nagios nagios-devel nagios-plugins\* gd gd-devel php gcc glibc glibc-common openssl

sudo cat > /etc/nagios3/conf.d/controller.cfg
# Generic host definition template – This is NOT a real host, just a template!

define host{
        host_name                       controller.cook.book
        address                         172.16.80.200
        notifications_enabled           1       ; Host notifications are enabled
        event_handler_enabled           1       ; Host event handler is enabled
        flap_detection_enabled          1       ; Flap detection is enabled
        failure_prediction_enabled      1       ; Failure prediction is enabled
        process_perf_data               1       ; Process performance data
        retain_status_information       1       ; Retain status information across program restarts
        retain_nonstatus_information    1       ; Retain non-status information across program restarts
                check_command                   check-host-alive
                max_check_attempts              10
                notification_interval           0
                notification_period             24×7
                notification_options            d,u,r
                contact_groups                  admins
        register                        1       ; DONT REGISTER THIS DEFINITION – ITS NOT A REAL HOST, JUST A TEMPLATE!
        }
EOF
sudo cp /etc/nagios3/conf.d/controller.cfg /etc/nagios3/conf.d/compute.cfg
sudo cp /etc/nagios3/conf.d/controller.cfg /etc/nagios3/conf.d/cinder.cfg
sudo cp /etc/nagios3/conf.d/controller.cfg /etc/nagios3/conf.d/quantum.cfg
sudo sed -i “s/controller/compute/” /etc/nagios3/conf.d/compute.cfg
sudo sed -i “s/172.16.80.200/172.16.80.201/” /etc/nagios3/conf.d/compute.cfg
sudo sed -i “s/controller/cinder/” /etc/nagios3/conf.d/cinder.cfg
sudo sed -i “s/172.16.80.200/172.16.80.211/” /etc/nagios3/conf.d/cinder.cfg
sudo sed -i “s/controller/quantum/” /etc/nagios3/conf.d/quantum.cfg
sudo sed -i “s/172.16.80.200/172.16.80.202/” /etc/nagios3/conf.d/quantum.cfg



cat >> /home/vagrant/.bashrc <<EOL

PS1="vm-\[\033[38;5;11m\]\h\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;45m\][\[$(tput sgr0)\]\[\033[38;5;6m\]\w\[$(tput sgr0)\]\[\033[38;5;45m\]]\[$(tput sgr0)\]\[\033[38;5;15m\]\n\[$(tput sgr0)\]\[\033[38;5;12m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;33m\]@\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]\[\033[38;5;6m\]\A\[$(tput sgr0)\]\[\033[38;5;15m\] \\$ \[$(tput sgr0)\]"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias vim='vim'

EOL


