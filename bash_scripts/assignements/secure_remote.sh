#!/bin/bash

#Author: cgalan@cloudbasesolutions.com
#License: Apache v2.0
#Description: Increase the security with disabling remote root login and installing fail2ban

set -e

echo "Checking which operating system you have: ";
[[ -f /etc/redhat-release ]] && OS=CentOS 
[[ -f /etc/lsb_release ]] && OS=Ubuntu    
[[ -f /etc/lsb-release ]] && OS=Ubuntu    

echo "You have $OS";
echo "Configuring your system...";

if [[ $OS == "CentOS" ]]; then
	
  sudo yum install epel-release -y; #fail2ban is avaible in epel-release
	sudo yum install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootlogin no"/g /etc/ssh/sshd_config
  
  sudo systemctl reload sshd;
  sudo systemctl restart fail2ban; #needed after changing the config file
  sudo systemctl enable fail2ban; 
fi

if [[ $OS == "Ubuntu" ]]; then
	sudo apt-get update;
  sudo apt-get install openssh-server openssh-client -y;
  sudo apt-get install fail2ban -y;

	sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
	sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
	sed -i s/"PermitRootLogin yes"/"PermitRootLogin no"/g /etc/ssh/sshd_config
  
  sudo service ssh reload; 
  sudo service fail2ban restart; #needed after changing the config file 
fi

set +e 

echo "Finished.";
