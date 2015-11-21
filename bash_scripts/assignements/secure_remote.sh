#!/bin/bash

#Author: cgalan@cloudbasesolutions.com
#License: Apache v2.0
#Description: Increase the security with disabling remote root login and installing fail2ban

echo "Checking which operating system you have: ";
[[ -f /etc/redhat-release ]] && OS=CentOS 
[[ -f /etc/lsb-release ]] && OS=Ubuntu    

echo "Configuring your system for $OS";

if [[ $OS == "CentOS" ]]; then
	
  sudo yum update -y; #Needed for updating the system packages
  sudo yum install epel-release -y; #Needed for installing fail2ban.
  sudo yum install fail2ban -y;

  sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf #increase the number of retries from 5 to 8
  sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
  sed -i s/"PermitRootLogin yes"/"PermitRootlogin no"/g /etc/ssh/sshd_config
  echo "PermitRootLogin no" >> /etc/centrifydc/ssh/sshd_config
  
  sudo systemctl reload sshd; #reloading the sshd service
  sudo systemctl restart fail2ban; #needed for realoading the configuration file
  sudo systemctl enable fail2ban; #enable fail2ban at startup
  sudo adreload #centrifydc needs to reload the AD users and OUs
  sudo adflush  #centrifydc needs to have the AD configuration restarted after updating the sshd config file
  kill -9 "$(pgrep -f "/usr/share/centrifydc/sbin/sshd -D")" #force kill centrifydc's sshd for updating the config
fi

if [[ $OS == "Ubuntu" ]]; then
	sudo apt-get update;
  sudo apt-get install openssh-server openssh-client -y;
  sudo apt-get install fail2ban -y;

  sed -i s/"maxretry = 5"/"maxretry = 8"/ /etc/fail2ban/jail.conf
  sed -i s/"#PermitRootLogin"/"PermitRootlogin"/g /etc/ssh/sshd_config
  sed -i s/"PermitRootLogin yes"/"PermitRootLogin no"/g /etc/ssh/sshd_config
  sed -i s/"PermitRootLogin without-password"/"PermitRootLogin no"/g /etc/ssh/sshd_config
  echo "PermitRootLogin no" >> /etc/centrifydc/ssh/sshd_config
  
  sudo service fail2ban restart;
  sudo service ssh reload
  sudo adreload
  sudo adflush
  kill -9 "$(pgrep -f "/usr/share/centrifydc/sbin/sshd -D")"
fi

echo "Finished.";
