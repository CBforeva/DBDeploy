### This init.pp file installs PostgreSQL.
### The following Puppet Module is required: puppetlabs/postgresql

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644 }

file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...
              Managed by Puppet to install and configure PostgreSQL Server \n",
}

class { 'postgresql::globals':
  manage_package_repo => true,
  version             => '9.4',
}->
class { 'postgresql::server':
  ip_mask_allow_all_users   => '0.0.0.0/0',
  listen_addresses          => '*',
  ipv4acls                  => ['host all all 0.0.0.0/0 trust'],
  #manage_firewall           => true,
  manage_pg_hba_conf        => true,
  postgres_password         => 'testPass',
}

#postgresql::server::db { 'testdb':
#  user     => 'testUser',
#  password => 'testPass',
#}

#postgresql::server::config_entry { 'shared_buffers':
#    value => '2048MB',  
#}   

#postgresql::server::config_entry { 'work_mem':   
#  value => '100MB',    
#}    
   
#postgresql::server::config_entry { 'effective_cache_size':   
#  value => '4096MB',   
#}    
   
#postgresql::server::config_entry { 'fsync':    
#  value => 'off',    
#}    
   
#postgresql::server::config_entry { 'full_page_writes':   
#  value => 'off',    
#}    
   
#postgresql::server::config_entry { 'synchronous_commit':   
#  value => 'off',    
#}    
   
#postgresql::server::db { 'testdb':   
#  user     => 'testUser',    
#  password => 'testPass',    
#}    
->   
##service { 'iptables':    
#  ensure => 'stopped',   
#}    