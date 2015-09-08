#!/bin/bash

[[ -f /etc/redhat-release ]] && OS=CentOS
[[ -f /etc/lsb_release ]] && OS=Ubuntu

echo $OS

if [[ $OS == "CentOS" ]]; then
	echo "Good";
	sudo yum install epel-release -y;
	sudo yum install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootlogin no"/g /etc/ssh/sshd_config
fi

if [[ $OS == "Ubuntu" ]]; then
	echo "Not good";
	sudo apt-get install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootLogin no"/g /etc/ssh/sshd_config
fi
