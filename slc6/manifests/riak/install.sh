#!/bin/bash
echo " "
echo "########################################"
echo "# WOOF -> jbussdieker/riak install     #"
echo "########################################"
puppet module install jbussdieker/riak

#echo " "
#echo "########################################"
#echo "# WOOF -> Apply init_riak_kv_env.pp    #"
#echo "########################################"
#puppet apply init_riak_kv_env.pp

echo " "
echo "########################################"
echo "# WOOF -> Apply init_riak.pp           #"
echo "########################################"
puppet apply init_riak.pp
echo " ... Possible bug in RIAK puppet module. Starting riak manually, NOT as a service... "

echo " "
echo "########################################"
echo "# WOOF -> Starting riak and ping it    #"
echo "########################################"
riak start
riak ping

