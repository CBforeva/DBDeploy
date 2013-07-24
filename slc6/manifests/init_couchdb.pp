### This init.pp file installs CouchDB.
### The following Puppet Module doesn't have any dependeny.

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure MongoDB. \n",
}

# CouchDB is available in the EPEL Repository.
package { 'couchdb': ensure => installed, }

# Copy-paster custom configuration.
file { '/etc/couchdb/default.ini':
  source  => 'puppet:///modules/couchdb/test_config.ini',
  owner   => 'root',
  group   => 'root',
  mode    => '640',
  notify  => Service['couchdb'],
  require => Package['couchdb'],
}

# Start the server and then relax.
service { 'couchdb':
  ensure     => running,
  enable     => true,
  hasstatus  => true,
  hasrestart => true, 
}

