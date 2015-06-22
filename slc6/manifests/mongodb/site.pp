### This site.pp requires the module: dwerder/mongodb

$puppetmaster="${fqdn}"

node mongo_shard_default {

  # Install MongoDB
  class { 'mongodb':
    package_name => 'mongodb-org',
    dbdir        => '/var/lib/mongodb/',
    logdir       => '/var/log/mongodb/',
    run_as_user  => 'mongod',
    run_as_group => 'mongod',
  }
  ->
  package { 'mongodb-org-mongos':
    ensure  => installed,
  }

  # install Shard
  mongodb::mongod { 'mongod_shard':
    mongod_instance => 'shard',
    mongod_port     => 27019,
    mongod_replSet  => '',
    mongod_shardsvr => 'true',
    mongod_rest     => 'false',
    mongod_add_options => ['auth = false', 'objcheck = false', 'journal = true'],
  }

  # Install the MongoDB Loadbalancer server
  mongodb::mongos { 'mongos_shardproxy':
    mongos_instance      => 'mongoproxy',
    mongos_port          => 27017,
    mongos_configServers => 'node1.cern.ch:27018',
  }
}

# This three nodes are shard members and run a mongoS

node 'node1.cern.ch' inherits mongo_shard_default { 
  mongodb::mongod { 'mongod_config':
    mongod_instance  => 'shardproxy',
    mongod_port      => 27018,
    mongod_replSet   => '',
    mongod_configsvr => 'true',
    mongod_rest      => 'false',
  }
}

node 'node2.cern.ch', 
     'node3.cern.ch',
     'node4.cern.ch',
     'node5.cern.ch' inherits mongo_shard_default { }

