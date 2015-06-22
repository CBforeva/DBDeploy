### This site.pp requires the module: dwerder/mongodb

$configserver="node1.cern.ch:27018"

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

# Install the MongoDB Query Router
mongodb::mongos { 'mongos_shardproxy':
  mongos_instance      => 'mongoproxy',
  mongos_port          => 27017,
  mongos_configServers => "${configserver}",
}

