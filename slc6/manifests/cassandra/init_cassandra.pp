### This init.pp file installs Cassandra from the DataStax repos..
### The following Puppet Module is a dependency: gini/cassandra
### For limits: erwbgy-limits

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...
              Managed by Puppet to install and configure a single Cassandra instance. \n",
}

class { 'limits':
     config => {
                '*'       => { 'nofile'  => { soft => '65536'   , hard => '65536',   },},
               },
     use_hiera => false,
}
->
package { 'jna':
  ensure => installed,
}
->
class { 'cassandra':
  cluster_name   => 'TestCluster',
  seeds          => ['cassnode1.cern.ch', 'cassnode2.cern.ch'],
  # For singlenode setup:
  #seeds          => ["${ipaddress}"],
  
  rpc_address    => '0.0.0.0', 
  listen_address => "${ipaddress}",

  # For further configs please check the module's init.pp file! 
  # Especially needed for the weak Vagrant setup:
  max_heap_size       => '4096M', # half of accessible memory.
  heap_newsize        => '400M', # 100MB/CPU core
  additional_jvm_opts => ['-Xss256k'],

  #auto_bootstrap = 'true', # this is missing from the template unfortunately.
  start_native_transport => 'true', # Needed for the native client.

  #thrift_framed_transport_size_in_mb => '100', # Check this if you are using it with Thrift.
  #thrift_max_message_length_in_mb    => '100', # Check this if you are using it with Thrift.
  #in_memory_compaction_limit_in_mb   => '100', # Check this if you are using it with Thrift.
}
->
service { 'iptables':
  ensure => stopped,
}

