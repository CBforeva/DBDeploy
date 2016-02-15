# This puppet manifest is installing OMD and make
# necessarry changes to fix known issues running it on CentOS 7.
# Required puppet modules are the following:
#   -> jfryman-selinux
#   -> maestrodev-wget

$rpmName = "labs-consol-stable.rhel7.noarch.rpm"
$rpmURL  = "https://labs.consol.de/repo/stable/rhel7/x86_64/${rpmName}"
$omdPackage = "omd-1.30.x86_64"

group { 'puppet':
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }
file { '/etc/motd':
  content => "Welcome! This node handles OMD!
              Managed by Puppet to install and configure CondDB service monitoring. \n",
}

# SELinux -> allow httpd network connections
selinux::boolean { 'httpd_can_network_connect': }
->
wget::fetch { "${rpmURL}":
  destination => "/root/${rpmName}",
  timeout     => 0,
  verbose     => false,
}
->
package { "${rpmName}":
  provider        => 'rpm',
  ensure          => installed,
  source          => "/root/${rpmName}",
  install_options => ['-v', '-h'],
  notify          => Package["${omdPackage}"],
}

package { "${omdPackage}":
  ensure  => installed,
  #require => Package["${rpmName}"],
}

# hotfix for hashlib version clash:
file { '/opt/omd/versions/1.30/lib/python/hashlib.py':
  source  => '/usr/lib64/python2.7/hashlib.py',
  owner   => 'root',
  group   => 'root',
  require => Package["${omdPackage}"],
}

