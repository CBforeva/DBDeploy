#!/bin/bash
echo " "
echo "########################################"
echo "# WOOF -> maestrodev-wget install      #"
echo "########################################"
puppet module install maestrodev-wget

echo " "
echo "########################################"
echo "# WOOF -> Apply init_hbase.pp          #"
echo "########################################"
puppet apply init_hbase.pp

echo " "
echo "########################################"
echo "# WOOF -> Starting HBase and ping it   #"
echo "########################################"
#riak start
#riak ping

