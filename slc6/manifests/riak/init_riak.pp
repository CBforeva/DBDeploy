### This init.pp file installs RIAK.
### The following Puppet Module is a dependency: jbussdieker/riak
### Also for limits: erwbgy-limits
### and sysctl:      fiddyspence-sysctl

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure RIAK. \n",
}

class { 'limits':
     config => {
                '*'       => { 'nofile'  => { soft => '4096'   , hard => '8192',   },},
               },
     use_hiera => false,
}
->
package { 'basho-repo':
  ensure   => present,
  source   => "http://yum.basho.com/gpg/basho-release-6-1.noarch.rpm",
  provider => rpm,
}
->
class { 'riak':
  node_name => 'riak@<host_name>',
  pb_ip     => '0.0.0.0',
  pb_port   => 8087,

  http_ip   => '0.0.0.0',
  http_port => '8098',
  # For the full config please check the module's init.pp file.
}
->
service { 'iptables':
  ensure => stopped,
}


