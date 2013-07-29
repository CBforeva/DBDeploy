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
  #port         => '27017',
  #dbpath       => '/var/lib/mongo',
  #nojournal    => true,  #Disable write-ahead jorunaling. Durability is lost on that case!
  #cpu          => true,  #Enables periodic logging of CPU utilization and IO wait.
  #noauth       => true,  #Turn on/off security.
  #verbose      => true,  #Increased verbosity.
  #objcheck     => true,  #Inspect client data (for driver developing mainly.)
  #notablescane => true,  #Turns off table scans. Scanning queries are disabled.
  #noprealloc   => true,  #Turns off pre-allocation of data files.
  #nssize       => ???,   #Specify .ns file sizes.
  # For other dba related switches check the module's init file.

}

