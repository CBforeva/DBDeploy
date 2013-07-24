### This init.pp file installs RIAK.
### The following Puppet Module is a dependency: haf/riak

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure RIAK. \n",
}

include riak
#class { 'riak': 
#  cfg => {
#    riak_core => {
#      https => { "__string__${$::ipaddress}" => 8443 }
#    }
#  }
#}

