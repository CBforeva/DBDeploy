### This init.pp file installs RIAK.
### The following Puppet Module is a dependency: jbussdieker/riak

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure RIAK. \n",
}

package { 'basho-repo':
  ensure   => present,
  source   => "http://yum.basho.com/gpg/basho-release-6-1.noarch.rpm",
  provider => rpm,
}
->
class { 'riak':
  node_name => 'riak@127.0.0.1',
  # For the full config please check the module's init.pp file.
}


