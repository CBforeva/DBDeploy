### This init.pp file installs MySQL.
### The following Puppet Module is required: puppetlabs/mysql

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...
              Managed by Puppet to install and configure a MySQL Server. \n",
}

# my.cnf -> [mysqld]
class { 'mysql::server': 
  override_options => {
    'mysqld' => { 'bind_address' => '0.0.0.0',
                  'max_connections' => '250',
                  'max_allowed_packet' => '100M',
                  'innodb_buffer_pool_size' => '512M', # Bigger -> More like an in-memory db.
                  #'innodb_buffer_pool_instances' => '16' <- only from MySQL 5.5
                  'innodb_log_file_size' => '128M',
                  'innodb_log_buffer_size' => '64M',
                  'innodb_flush_log_at_trx_commit' => '1', # <- set to 2 for flush transactions to OS file cache. (lost full ACID.)
                  'innodb_thread_concurrency' => '5', # <- 2 * NumOf(CPU) + NumOf(Disks)
    }
  }
}
->
mysql::db { 'testdb':
  user     => 'testUser',
  password => 'testPass',
  host     => '%',
  grant    => ['all'],
  require  => Class['::mysql::server'],
}
->
service { 'iptables':
  ensure => 'stopped',
}

