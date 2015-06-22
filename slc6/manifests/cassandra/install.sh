#!/bin/bash
echo " "
echo "########################################"
echo "# WOOF -> gini/cassandra install       #"
echo "########################################"
puppet module install gini/cassandra

echo " "
echo "########################################"
echo "# WOOF -> swapoff --all                #"
echo "########################################"
swapoff --all

echo " "
echo "########################################"
echo "# WOOF -> Apply init_cassandra.pp      #"
echo "########################################"
puppet apply init_cassandra.pp

echo " "
echo "########################################"
echo "# WOOF -> Ping cassandra               #"
echo "########################################"
service cassandra status

