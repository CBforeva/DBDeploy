### This site.pp file installs Cassandra from the DataStax repos..
### The following Puppet Module is a dependency: gini/cassandra

$seed1="node1.cern.ch"
$seed2="node2.cern.ch"

node cassandra_shard_default {
  package { 'jna':
    ensure => installed,
  }
  ->
  class { 'cassandra':
    cluster_name   => 'TestCluster',
    seeds          => [${seed1}, ${seed2}],

    rpc_address    => '0.0.0.0', 
    listen_address => "${ipaddress}",

    max_heap_size       => '4096M',      # half of accessible memory.
    heap_newsize        => '400M',       # 100MB/CPU core
    additional_jvm_opts => ['-Xss256k'], # see Cassandra docs

    start_native_transport => 'true',    # Needed for the native client.

    #thrift_framed_transport_size_in_mb => '100', # Check this, if you are using it with Thrift.
    #thrift_max_message_length_in_mb    => '100', # Check this, if you are using it with Thrift.
    #in_memory_compaction_limit_in_mb   => '100', # Check this, if you are using it with Thrift.
}

node 'node1.cern.ch',
     'node2.cern.ch',
     'node3.cern.ch',
     'node4.cern.ch',
     'node5.cern.ch' inherits cassandra_shard_default { }

