#!/bin/bash

[[ -f /etc/redhat-release ]] && OS=CentOS
[[ -f /etc/lsb_release ]] && OS=Ubuntu

echo $OS

if [[ $OS == "CentOS" ]]; then
	sudo yum install epel-release -y;
	sudo yum install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootlogin no"/g /etc/ssh/sshd_config
    sudo service reload sshd
fi

if [[ $OS == "Ubuntu" ]]; then
	sudo apt-get install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootLogin no"/g /etc/ssh/sshd_config
    sudo service ssh restart
fi
