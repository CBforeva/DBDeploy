### This init.pp file installs Hypertable Standalone.
### Required module for limits: erwbgy-limits
### Required module for wget:   maestrodev-wget
### Required module for lines:  puppetlabs/stdlib

$htNameVersion = "hypertable-0.9.8.0"
$htVersion     = "0.9.8.0"
$htArch        = "linux-x86_64"
$rpmURL        = "http://cdn.hypertable.com/packages/0.9.8.0/hypertable-0.9.8.0-linux-x86_64.rpm"

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure Hypertable Standalone. \n",
}

class { 'limits':
     config => {
                '*'       => { 'nofile'  => { soft => '65536'   , hard => '65536',   },},
               },
     use_hiera => false,
}
->
service { 'iptables':
  ensure => stopped,
}
->
package { ['perl-Bit-Vector',
           'perl-Class-Accessor',
           'perl-HTTP-Request-AsCGI',
           'perl-IO-String',
           'perl-Crypt-SSLeay']:
  ensure => installed,
}
->
wget::fetch { "${rpmURL}":
  destination => "/root/${htNameVersion}-${htArch}.rpm",
  timeout     => 0,
  verbose     => false,
}
->
package { 'hypertable-package':
  provider        => 'rpm',
  ensure          => installed,
  source          => "/root/${htNameVersion}-${htArch}.rpm",
  install_options => ['-i', '-v', '-h', '--replacepkgs', '--nomd5'],
}

file { ['/etc/opt/hypertable', '/var/opt/hypertable']:
  ensure  => directory,
  recurse => true,
  owner   => 'root',
  group   => 'root',
  require => Package['hypertable-package'],
}

file_line { '/opt/hypertable/current/conf/hypertable.cfg':
  path  => '/opt/hypertable/current/conf/hypertable.cfg',
  match => 'Hyperspace.Replica.Host',
  line  => "Hyperspace.Replica.Host=${ec2_hostname}",
  require => Package['hypertable-package'],
}

exec { "/opt/hypertable/$htVersion/bin/fhsize.sh":
  require => File['/etc/opt/hypertable', '/var/opt/hypertable'],
}

