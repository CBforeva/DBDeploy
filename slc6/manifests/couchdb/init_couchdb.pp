### This init.pp file installs CouchDB.
### This manifest doesn't have any module dependeny.

group { 'puppet':
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }
file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...!
              Managed by Puppet to install and configure CouchDB. \n",
}

# Create user and group for couchdb:
group { 'couchdb': 
  ensure  => 'present', 
  gid     => 1000,
}
user { 'couchdb':
  ensure  => present,
  gid     => 'couchdb',
  shell   => '/bin/bash',
  home    => '/var/lib/couchdb',
  require => Group['couchdb'],
}

# CouchDB is available in the EPEL Repository. + Disable firewall.
service { 'iptables':
  ensure  => stopped,
  require => User['couchdb'],
}
package { 'couchdb': 
  ensure  => installed, 
  notify  => Service['iptables'],
}

# Copy-paste custom configuration.
file { '/etc/couchdb/local.ini':
  source  => 'puppet:///modules/couchdb/test_config.ini',
  owner   => 'couchdb',
  group   => 'couchdb',
  mode    => '640',
  notify  => Service['couchdb'],
  require => Package['couchdb'],
}
file { ['/usr/local/etc/couchdb', '/var/log/couchdb', '/var/lib/couchdb', '/var/run/couchdb']:
  ensure  => directory,
  recurse => true,
  owner   => 'couchdb',
  group   => 'couchdb',
}

# Start the server.
service { 'couchdb':
  ensure     => running,
  enable     => true,
  hasstatus  => true,
  hasrestart => true,
  require    => File['/usr/local/etc/couchdb',
                     '/var/lib/couchdb',
                     '/var/log/couchdb',
                     '/var/run/couchdb'],
}

