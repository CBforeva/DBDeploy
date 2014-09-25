Scripts
=======

Two simple scripts were made to fast prepare CERN OpenStack instances for deploying databases on them.
Just scp them over to the VM, and first run prepare.sh, after the VM has been restarted, run resize.sh.

prepare.sh:
-----------
1.: Creating testUser for the monitoring sampler
2.: Install packages: dstat, iperf, puppet
3.: Install puppet modules: fiddyspence-sysctl, erwbgy-limits
4.: Initialize VM by fine-tuning kernel resources
5.: Extend partition: growpart /dev/vda 2
6.: Restart the VM.: shutdown -r now

resize.sh:
----------
1.: Resize physical volume: pvresize /dev/vda2
2.: Extend logical volume: lvextend -l +100%FREE /dev/mapper/VolGroup00-LogVol00
3.: Resize filesystem: resize2fs /dev/mapper/VolGroup00-LogVol00
4.: Turn off firewall before performance testing: service iptables stop

monitoring.sh:
--------------
1.: Start a DSTAT process with 1030 sec timeout.
2.: Start an IOSTAT process collecting sampler for 1030 seconds.


