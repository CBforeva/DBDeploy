
node mongo_sharding_default {
  # Install MongoDB
  include mongodb
  # Install the mongoDB Shard Server
  mongodb::mongod { 'mongod_shard':
    mongod_instance => "mongoshard",
    mongod_port     => '27019',
    mongod_shardsvr => 'true'
  }
  #mongodb::mongod { 'mongod_Shard2': mongod_instance => "Shard2", mongod_port => '27020', mongod_replSet => "Shard2", mongod_shardsvr => 'true' }
  #mongodb::mongod { 'mongod_Shard3': mongod_instance => "Shard3", mongod_port => '27021', mongod_replSet => "Shard3", mongod_shardsvr => 'true' }
  #mongodb::mongod { 'mongod_Shard4': mongod_instance => "Shard4", mongod_port => '27022', mongod_replSet => "Shard4", mongod_shardsvr => 'true' }

  # Install the MongoDB Loadbalancer server
  mongodb::mongos { 'mongos_profile':
    mongos_instance      => 'mongoproxy',
    mongos_port          => 27017,
    mongos_configServers => 'mongo-confignode.cern.ch' 
  }
}

node 'mongo-node1.cern.ch',
     'mongo-node2.cern.ch',
     'mongo-node3.cern.ch',
     'mongo-node4.cern.ch' inherits mongo_sharding_defaults { }


node 'mongo-confignode.cern.ch' {
  include mongodb
  mongodb::mongod { 'mongod_config':
    mongod_instance  => 'mongoconfig',
    mongod_port      => '27018',
    mongod_replSet   => '',
    mongod_configsvr => 'true'
  }
}

