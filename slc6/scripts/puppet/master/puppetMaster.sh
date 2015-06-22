#!/bin/bash

echo " "
echo "########################################"
echo "# WOOF -> Stopping firewall            #"
echo "########################################"
service iptables stop

echo " "
echo "########################################"
echo "# WOOF -> Installing puppet            #"
echo "########################################"
yum -y install puppet
yum -y install puppet-server

echo " "
echo "########################################"
echo "# WOOF -> Generate default config      #"
echo "########################################"
HOSTNAME=$(hostname --fqdn)
puppetmasterd --genconfig > /etc/puppet/puppet.conf

echo " "
echo "########################################"
echo "# WOOF -> Starting puppetmaster        #"
echo "########################################"
setenforce 0
sudo service puppetmaster start

