### This init.pp file installs MongoDB.
### The following Puppet Module is a dependency: puppetlabs/mongodb

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...
              Managed by Puppet to install and configure MongoDB. \n",
}

class { '::mongodb::globals':
  manage_package_repo => true,
}
->
class { '::mongodb::server':
  # General:
  bind_ip      => ['0.0.0.0'],
  port         => 27017,
  maxconns     => 250,
  auth         => false,

  # Performance related:
  journal      => true,   # Enable/Disable write-ahead jorunaling. (Durability is lost if false!)
  noprealloc   => false,  # Enable/Disable pre-allocation of data files. (If true, performance loss guaranteed.)
  #slowms      => '500ms' # Threshold for mongod to consider a query slow. (Default: 100 ms)
  #nssize      => '16',   # Size of namespace files. (Default is 16.)
  #smallfiles  => true,   # if you have a large number of databases that each holds a small quantity of data. 

  # Sharding: not supported from puppetlabs... Use site.pp instead.

  # Operational:
  objcheck     => true,  #Inspect client data. like: Inserted docs hold format, etc. (For driver developing mainly.)
  notablescan  => true,  #Turns off table scans. Scanning queries are disabled.
}
#->
#mongodb::db { 'testdb':
#  user        => 'testUser',
#  password    => 'testPass',
#  tries       => 10,
#}

