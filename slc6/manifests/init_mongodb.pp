### This init.pp file installs MongoDB.
### The following Puppet Module is a dependency: puppetlabs/mongodb

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure MongoDB. \n",
}

class { 'mongodb':
  enable_10gen => true,
}

