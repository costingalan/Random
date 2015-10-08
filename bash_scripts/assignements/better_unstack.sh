#!/bin/bash

#added || /bin/true because killall on an nonexistent process return an error

sudo killall --ignore-case -9 "/usr/bin/python" || /bin/true  
sudo killall --ignore-case -9 "python"  || /bin/true
sudo killall --ignore-case -9 "SCREEN" || /bin/true
sudo killall --ignore-case -9 "nova-api" || /bin/true 
sudo killall --ignore-case -9 "cinder-api" || /bin/true
sudo killall --ignore-case -9 "neutron-api" || /bin/true
sudo killall --ignore-case -9 "glance-api" || /bin/true
sudo killall --ignore-case -9 "quantum" || /bin/true
sudo killall --ignore-case -9 "heat-api" || /bin/true
sudo killall --ignore-case -9 "rabbitmq" || /bin/true
sudo killall --ignore-case -9 "dstat" || /bin/true
sudo killall --ignore-case -9 "keystone" || /bin/true
sudo killall --ignore-case -9 "ovsdb-server" || /bin/true
sudo killall --ignore-case -9 "ovs-vswitchd" || /bin/true
sudo killall --ignore-case -9 "apache2" || /bin/true
