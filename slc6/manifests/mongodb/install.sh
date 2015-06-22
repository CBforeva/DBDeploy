#!/bin/bash
echo " "
echo "########################################"
echo "# WOOF -> puppetlabs/mongodb install   #"
echo "########################################"
puppet module install puppetlabs/mongodb

echo " "
echo "########################################"
echo "# WOOF -> Apply init_mongodb.pp      #"
echo "########################################"
puppet apply init_mongodb.pp

echo " "
echo "########################################"
echo "# WOOF -> Ping mongod                  #"
echo "########################################"
service mongod status

