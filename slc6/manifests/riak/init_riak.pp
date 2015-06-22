### This init.pp file installs RIAK.
### The following Puppet Module is a dependency: jbussdieker/riak

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome! This node is ready to be performance tested...
              Managed by Puppet to install and configure RIAK. \n",
}

package { 'basho-repo':
  ensure   => present,
  source   => "http://yum.basho.com/gpg/basho-release-6-1.noarch.rpm",
  provider => rpm,
}
->
class { 'riak':
  node_name => "riak@${ipaddress}",
  pb_ip     => '0.0.0.0',
  pb_port   => 8087,

  http_ip   => '0.0.0.0',
  http_port => '8098',

  # For the full config please check the module's init.pp file.
  # For frequent settings, some additional options are added here:

  # kernel settings
  # epmd_listen_min => 0,
  # epmd_listen_max => 65535,

  # riak_kv
  # storage_backend                => 'riak_kv_bitcask_backend',
  # anti_entropy                   => 'on',
  # anti_entropy_build_limit       => {
  #   num_builds   => 1,
  #   per_timespan => 3600000,
  # },
  # anti_entropy_expire            => 604800000,
  # anti_entropy_concurrency       => 2,
  # anti_entropy_tick              => 15000,
  # anti_entropy_data_dir          => '/var/lib/riak/anti_entropy',
  # anti_entropy_leveldb_opts      => {
  #   write_buffer_size => 4194304,
  #   max_open_files    => 20,
  # },

}

