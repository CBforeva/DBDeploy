#!/bin/bash

echo " "
echo "########################################"
echo "# WOOF -> creating testUser            #"
echo "########################################"
useradd testUser
echo -e "testPass\ntestPass" | (passwd testUser)

echo " "
echo "########################################"
echo "# WOOF -> Install dstat, iperf, puppet #"
echo "########################################"
yum -y install dstat
yum -y install perl-Time-Out.noarch
yum -y install iperf
yum -y install puppet

echo " "
echo "########################################"
echo "# WOOF -> Puppet limits and sysctl     #"
echo "########################################"
puppet module install fiddyspence-sysctl
puppet module install erwbgy-limits
puppet module install saz-ssh

echo " "
echo "######################################"
echo "# WOOF -> Initialize VM:             #"
echo "######################################"
puppet apply /root/slc6/manifests/init_vm.pp

echo " "
echo "########################################"
echo "# WOOF -> Extending partition:         #"
echo "########################################"
growpart /dev/vda 2

echo " "
echo "########################################"
echo "# WOOF -> Done... Restarting VM.       #"
echo "########################################"
shutdown -r now

