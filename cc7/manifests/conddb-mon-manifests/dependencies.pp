# This puppet manifest collection is installing OMD and make
# necessarry changes to fix known issues running it on CentOS 7.
# Required puppet modules are the following:
#   -> jfryman-selinux
#   -> maestrodev-wget --version 1.7.3
#
# dependencies.pp: It fetches all the necessary OMD backups for the new PROD site,
#                  and also installs the labs-consol repository. The omd.pp manifest
#                  is requiring most of the information here.


$omdPackage     = "omd-1.30.x86_64"
$rpmName        = "labs-consol-stable.rhel7.noarch.rpm"
#$prodBackupName = "prod-backup-20160316.tar.gz"
$prodBackupName = "omd-backup-test.tar.gz"
$chmkBackupName = "checkmk-agent-local.tar.gz"

#$toFetch = [
#  "https://labs.consol.de/repo/stable/rhel7/x86_64/${rpmName}",
#  "http://rsipos.web.cern.ch/rsipos/${prodBackupName}",
#  "http://rsipos.web.cern.ch/rsipos/${chmkBackupName}",
#]

# SELinux -> allow httpd network connections
selinux::boolean { 'httpd_can_network_connect': }
->
wget::fetch { "http://rsipos.web.cern.ch/rsipos/${prodBackupName}":
  destination => "/root/",
  timeout     => 0,
  verbose     => true,
}
->
wget::fetch { "http://rsipos.web.cern.ch/rsipos/${chmkBackupName}":
  destination => "/root/",
  timeout     => 0,
  verbose     => true,
}
->
wget::fetch { "https://labs.consol.de/repo/stable/rhel7/x86_64/${rpmName}":
  destination => "/root/",
  timeout     => 0,
  verbose     => true,
}
->
package { "${rpmName}":                 # Install the labs-consol repository.
  provider        => 'rpm',
  ensure          => installed,
  source          => "/root/${rpmName}",
  install_options => ['-v', '-h', '--replacepkgs'],
  notify          => Package["${omdPackage}"],
}

