#!/bin/bash
echo " "
echo "########################################"
echo "# WOOF -> wget, stdlib    install      #"
echo "########################################"
puppet module install maestrodev-wget
puppet module install puppetlabs/stdlib

echo " "
echo "########################################"
echo "# WOOF -> Apply init_hbase.pp          #"
echo "########################################"
puppet apply init_hbase.pp

