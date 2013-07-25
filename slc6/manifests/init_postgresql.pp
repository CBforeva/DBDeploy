### This init.pp file installs PostgreSQL.
### The following Puppet Module is required: puppetlabs/postgresql

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure a PostgreSQL Server \n",
}

class { 'postgresql::server': 
  config_hash => {
    'ip_mask_deny_postgres_user' => '0.0.0.0/32',
    'ip_mask_allow_all_users'   => '0.0.0.0/0',
    'listen_addresses'          => '*',
    'ipv4acls'                  => ['all'],
    'manage_redhat_firewall'    => true,
    'manage_pg_hba_conf'        => false,
    'postgres_password'         => 'testPass',
  },
}

postgresql::database_user { 'testUser':
  password_hash => 'testPass',
}
->
postgresql::db { 'testdb':
  user     => 'testUser',
  password => 'testPass',
}


