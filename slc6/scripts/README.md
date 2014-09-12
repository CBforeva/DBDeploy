Scripts
=======

Two simple scripts were made to fast prepare CERN OpenStack instances for deploying databases on them.
Just scp them over to the VM, and first run prepare.sh, after the VM has been restarted, run resize.sh.

prepare.sh:
-----------
1.: Install packages: dstat, iperf, puppet
2.: Install puppet modules: fiddyspence-sysctl, erwbgy-limits
3.: Extend partition: growpart /dev/vda 2
4.: Restart the VM.: shutdown -r now

resize.sh:
-----------
1.: Resize physical volume: pvresize /dev/vda2
2.: Extend logical volume: lvextend -l +100%FREE /dev/mapper/VolGroup00-LogVol00
3.: Resize filesystem: resize2fs /dev/mapper/VolGroup00-LogVol00
4.: Turn off firewall before performance testing: service iptables stop


