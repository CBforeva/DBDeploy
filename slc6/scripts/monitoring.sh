#!/bin/bash
#dstat -T -c -d -r -g -i -l -m -n -s --nocolor --output /dstat/dstat.csv > /dev/null &

echo "WOOF --> Starting a DSTAT process... It will terminate in 1030 seconds..."
timeout 1030 dstat -T -c -d -r -g -i -l -m -n -s -p -y --fs --ipc --lock --raw --socket --tcp --udp --unix --vm --nocolor --output ~/dstat.csv > /dev/null &
echo "WOOF --> Starting an IOSTAT process... 1 SPS, collecting 1030 samples..."
iostat -cdxtm /dev/vda 1 1030 > ~/iostat.csv &

