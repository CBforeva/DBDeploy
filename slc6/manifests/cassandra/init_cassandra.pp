### This init.pp file installs Cassandra from the DataStax repos..
### The following Puppet Module is a dependency: smarchive/cassandra

#group { "puppet":
#  ensure => "present",
#}

#File { owner => 0, group => 0, mode => 0644, }

#file { '/etc/motd':
#  content => "Welcome to your Vagrant-built virtual machine!
#              Managed by Puppet to install and configure a single Cassandra instance. \n",
#}

package {'jna':
  ensure => installed,
}
->
class { 'cassandra':
  cluster_name => 'TestCluster',
  seeds        => ['127.0.0.1',],
  # For further configs please check the module's init.pp file! 
  # Especially needed for the weak Vagrant setup:
  max_heap_size       => '400M',
  heap_newsize        => '200M',
  additional_jvm_opts => ['-Xss256k'],
}
->
file { '/var/lib/cassandra':
  ensure => directory,
  owner  => 'cassandra',
  group  => 'cassandra',
  mode   => '0755',
}
->
package { 'opscenter-free':
  ensure => installed,
  notify => Service['opscenterd'],
}

service { 'opscenter-agent':
  ensure     => running,
  enable     => true,
  hasstatus  => true,
  hasrestart => true,
}

