### This init.pp file installs Cassandra from the DataStax repos..
### The following Puppet Module is a dependency: smarchive/cassandra

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure a single Cassandra instance. \n",
}

class { 'cassandra':
  cluster_name => 'TestCluster',
  seeds        => ['127.0.0.1',],
  # For further configs please check the module's init.pp file!
}

