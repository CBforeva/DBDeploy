### This puppet manifest creates the associated data directory for Hypertable.

$dataDirectory = "/var/lib/hypertable-fs"

# sudo mkdir -p /data/hypertable/fs
file { "$dataDirectory":
  ensure  => directory,
  recurse => true,
  purge   => true,
  force   => true,
  owner   => 'root',
  group   => 'root',
}
->
file { '/opt/hypertable/current/fs':
   ensure => link,
   target => "$dataDirectory",
   force  => true,
}
->
file_line { '/opt/hypertable/current/conf/hypertable.cfg':
  path  => '/opt/hypertable/current/conf/hypertable.cfg',
  match => 'Hyperspace.Replica.Host',
  line  => "Hyperspace.Replica.Host=${ec2_hostname}",
  #require => Package['hypertable-package'],
}

