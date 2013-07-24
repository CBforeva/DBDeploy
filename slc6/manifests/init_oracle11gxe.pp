### This init.pp file installs Oracle 11g XE.
### Dependency module: codescape/vagrant-oracle-xe

group { "puppet":
  ensure => "present",
}

Package { provider => "yum" }

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install Oracle 11g XE \n",
}

include oracle::server
include oracle::xe

