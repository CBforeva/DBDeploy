### This init.pp file installs MySQL.
### The following Puppet Module is required: puppetlabs/mysql

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure a MySQL Server \n",
}

class { 'mysql::server': 
  config_hash => {
    'root_password' => 'testPass', 
    'bind_address'  => 'localhost',
    'port'          => '3306',
  },
}

mysql::db { 'testdb':
  user     => 'testUser',
  password => 'testPass',
  host     => 'localhost',
  grant    => ['all'],
  require  => Class['mysql::server'],
}

#database_user { 'testUser@%':
#  ensure        => present,
#  password_hash => mysql_password('testPass'),
#  require       => Class['mysql::server'],
#}

#database { 'testdb':
#  ensure  => present,
#  charset => 'utf8',
#  require => Type[''],
#}

#database_grant { 'testdb@%/testUser':
#  privileges => [all],
#}

