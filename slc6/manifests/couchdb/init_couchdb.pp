### This init.pp file installs CouchDB.
### The following Puppet Module doesn't have any dependeny.

group { 'puppet':
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure CouchDB. \n",
}

# Create directories that will be needed.
#file { '/usr/local/var':     ensure => directory, }
#file { '/usr/local/var/lib': ensure => directory, require => File['/usr/local/var'], }
#file { '/usr/local/var/lib/couchdb': 
#  ensure  => directory,
#  group   => 'couchdb',
#  recurse => true,
#  require => File['/usr/local/var/lib']
#}


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
#  require => File['/usr/local/var/lib/couchdb'], 
}

service { 'iptables':
  ensure  => stopped,
  require => User['couchdb'],
}
# CouchDB is available in the EPEL Repository. + Disable firewall.
package { 'couchdb': 
  ensure  => installed, 
  notify  => Service['iptables'],
}

# Copy-paster custom configuration.
file { '/etc/couchdb/default.ini':
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

# Start the server and then relax.
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

