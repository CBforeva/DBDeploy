
node mongo_sharding_default {
  # Install MongoDB
  include mongodb

  # Install the mongoDB Shard Server
  mongodb::mongod { 'mongod_Shard1': mongod_instance => "Shard1", mongod_port => ''}

}

