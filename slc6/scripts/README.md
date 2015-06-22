Scripts
=======
Some simple scripts were made in order to conveniently configure CERN OpenStack instances, and deploy databases on them.

prepare.sh:
-----------
 + 1.: Creating testUser for the monitoring sampler
 + 2.: Install packages: dstat, iperf, puppet
 + 3.: Install puppet modules: fiddyspence-sysctl, erwbgy-limits
 + 4.: Create dummy user: "testUser" with "testPass"
 + 5.: Extend partition: growpart /dev/vda 2
 + 6.: Restart the VM.: shutdown -r now

resize.sh:
----------
 + 1.: Resize physical volume: pvresize /dev/vda2
 + 2.: Extend logical volume: lvextend -l +100%FREE /dev/mapper/VolGroup00-LogVol00
 + 3.: Resize filesystem: resize2fs /dev/mapper/VolGroup00-LogVol00
 + 4.: Fine-tune kernel parameters and EDM profile.
 + 5.: Turn off firewall before performance testing: service iptables stop

monitoring.sh:
--------------
 + 1.: Start a DSTAT process with 1030 sec timeout.
 + 2.: Start an IOSTAT process collecting sampler for 1030 seconds.

mountVolume.sh:
---------------
Mounts attached volumes if needed.

puppet:
-------
Contains agent and master specific scripts for starting catalog runs, accepting certificates, etc.

