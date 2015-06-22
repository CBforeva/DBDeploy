### For setting up riak_kv_env with good values.
### Module needed: fiddyspence-sysctl
### Module needed: erwbgy-limits
### Module needed: saz-ssh

### Sysctl
sysctl { 'vm.swappiness':                ensure => 'present', permanent => 'yes', value => '0',}
sysctl { 'vm.max_map_count':             ensure => 'present', permanent => 'yes', value => '131072',}

sysctl { 'net.core.somaxconn':           ensure => 'present', permanent => 'yes', value => '4000',}

sysctl { 'net.ipv4.tcp_max_syn_backlog': ensure => 'present', permanent => 'yes', value => '40000',}
sysctl { 'net.ipv4.tcp_tw_reuse':        ensure => 'present', permanent => 'yes', value => '1',}
sysctl { 'net.ipv4.tcp_fin_timeout':     ensure => 'present', permanent => 'yes', value => '15',}
sysctl { 'net.ipv4.tcp_keepalive_time':  ensure => 'present', permanent => 'yes', value => '300',} ## Mongo suggestion.
sysctl { 'net.ipv4.tcp_keepalive_intvl': ensure => 'present', permanent => 'yes', value => '30',}

sysctl { 'net.ipv4.tcp_timestamps':      ensure => 'present', permanent => 'yes', value => '0',}
sysctl { 'net.ipv4.tcp_sack':            ensure => 'present', permanent => 'yes', value => '1',}
sysctl { 'net.ipv4.tcp_window_scaling':  ensure => 'present', permanent => 'yes', value => '1',}

### Optional, may improve performance on a 10Gb network.
#sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '8388608',}
#sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '8388608',}
#sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '8388608',}
#sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '8388608',}
#sysctl { 'net.core.netdev_max_backlog':   ensure => 'present', permanent => 'yes', value => '10000',}

### Limits.
class { 'limits':
  config => {
    '*'    => { 'nproc'   => { soft => '10240' },
                'nofile'  => { soft => '65536',     hard => '65536' },
                'memlock' => { soft => 'unlimited', hard => 'unlimited' }, 
                'as'      => { soft => 'unlimited', hard => 'unlimited' },
    },
    'root' => { 'nofile'  => { soft => '65536',     hard => '65536' },
                'memlock' => { soft => 'unlimited', hard => 'unlimited' },
                'as'      => { soft => 'unlimited', hard => 'unlimited' },
    },
  },
  use_hiera => false,
}

### Create dummy user and allof SSH for it. Ultra unsafe.. I know... but it's a test machine.
user { 'testUser':
  ensure => present,
  shell => '/bin/bash',
  home => '/home/testUser',
  managehome => 'true',
  password => '$1$IufVSfkl$D4ekpxRMvM9sskSMnHKhl/',
}
->
class { 'ssh::server':
  options => {
    #'ChrootDirectory' => '%h',
    #'ForceCommand' => 'internal-sftp',
    'PasswordAuthentication' => 'yes',
    #'AllowTcpForwarding' => 'no',
    #'X11Forwarding' => 'yes',
    #'Port' => [22, 2222, 2288],
  },
}

