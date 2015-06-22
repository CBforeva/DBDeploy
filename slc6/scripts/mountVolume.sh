#!/bin/bash

echo " "
echo "######################################"
echo "# WOOF -> Creating fs on /dev/vdb    #"
echo "######################################"
mkfs -t ext4 -L testvol /dev/vdb

echo " "
echo "######################################"
echo "# WOOF -> Mounting volume: /dev/vdb  #"
echo "######################################"
mount -L testvol /mnt

echo " "
echo "######################################"
echo "# WOOF -> DF:  #"
echo "######################################"
df -lah

echo " "
echo "######################################"
echo "# WOOF -> Done                       #"
echo "######################################"

