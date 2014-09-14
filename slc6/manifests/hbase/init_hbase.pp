### This init.pp file installs HBase Standalone.
### Required module for limits: erwbgy-limits
### Required module for wget:   maestrodev-wget
### Required module for lines:  puppetlabs/stdlib

$cdh4PackName  = "cloudera-cdh-4-0.x86_64"
$rpmURL        = "http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/${cdh4PackName}.rpm"

$datadir       = "/data_dir/"

group { "puppet":
  ensure => "present",
}

File { owner => 0, group => 0, mode => 0644, }

file { '/etc/motd':
  content => "Welcome to your Vagrant-built virtual machine!
              Managed by Puppet to install and configure HBase Standalone. \n",
}

package { 'java-1.7.0-openjdk':
#           'perl-Class-Accessor',
#           'perl-HTTP-Request-AsCGI',
#           'perl-IO-String',
#           'perl-Crypt-SSLeay']:
  ensure => installed,
}
->
wget::fetch { "${rpmURL}":
  destination => "/root/${cdh4PackName}.rpm",
  timeout     => 0,
  verbose     => false,
}
->
package { "${cdh4PackName}.rpm":
  provider        => 'rpm',
  ensure          => installed,
  source          => "/root/${cdh4PackName}.rpm",
  install_options => ['--nogpgcheck'],
  notify          => Package['hbase-master'],
}

package { 'hbase-master':
  ensure  => installed,
}

file { 'datadir' :
  path    => "${datadir}",
  ensure  => directory,
  recurse => true,
  owner   => 'hbase',
  group   => 'hbase',
  require => Package['hbase-master'],
}

file_line { '/etc/zookeeper/conf/zoo.cfg':
  path  => '/etc/zookeeper/conf/zoo.cfg',
  match => 'dataDir',
  line  => "dataDir=${datadir}/zookeeper/",
  require => File['datadir'],
}

# Copy-paste custom configuration.
file { '/etc/hbase/conf/hbase-site.xml':
  source  => '/root/hbase-site.xml',
  owner   => 'hbase',
  group   => 'hbase',
  mode    => '640',
  require => File['datadir'],
}

