### This init.pp file installs MySQL.
### The following Puppet Module is required: puppetlabs/mysql
### Also it's dependencies: puppetlabs/stdlib

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure a MySQL Server \n",
}

# Full default settings:
#include '::mysql::server'

# my.cnf -> [mysqld]
class { 'mysql::server': 
  override_options => {
    'mysqld' => { 'max_connections' => '100',
                  'max_allowed_packet' => '100M',
    }
  }
}
->
mysql::db { 'testdb':
  user     => 'testUser',
  password => 'testPass',
  host     => 'localhost',
  grant    => ['all'],
  require  => Class['::mysql::server'],
}
->
database_user { 'testUser@%':
  ensure        => present,
  password_hash => mysql_password('testPass'),
}
->
database { 'testdb':
  ensure  => present,
  charset => 'utf8',
}
->
database_grant { 'testdb@%/testUser':
  privileges => [all],
}

