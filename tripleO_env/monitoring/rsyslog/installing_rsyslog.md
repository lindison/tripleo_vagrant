### Installing the rsyslog server

`yum install rsyslog`

Allow SELinux to allow rsyslog traffic  

`semanage port -a -t syslogd_port_t -p udp 514`

Add the following lines to /etc/rsyslog.conf

``$template TmplMsg, "/var/log/%HOSTNAME%/%PROGRAMNAME%.log"
$template TmplAuth, "/var/log/%HOSTNAME%/%PROGRAMNAME%.log"

authpriv.*   ?TmplAuth
*.info,mail.none,authpriv.none,cron.none   ?TmplMsg`
