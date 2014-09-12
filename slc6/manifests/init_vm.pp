### For setting up riak_kv_env with good values.
### Module needed: fiddyspence-sysctl

sysctl { 'vm.swappiness':                 ensure => 'present', permanent => 'yes', value => '0',}

sysctl { 'net.ipv4.tcp_max_syn_backlog':  ensure => 'present', permanent => 'yes', value => '40000',}
sysctl { 'net.ipv4.tcp_tw_reuse':         ensure => 'present', permanent => 'yes', value => '1',}
sysctl { 'net.ipv4.tcp_fin_timeout':      ensure => 'present', permanent => 'yes', value => '15',}

sysctl { 'net.core.rmem_default':         ensure => 'present', permanent => 'yes', value => '8388608',}
sysctl { 'net.core.rmem_max':             ensure => 'present', permanent => 'yes', value => '8388608',}
sysctl { 'net.core.wmem_default':         ensure => 'present', permanent => 'yes', value => '8388608',}
sysctl { 'net.core.wmem_max':             ensure => 'present', permanent => 'yes', value => '8388608',}
sysctl { 'net.core.netdev_max_backlog':   ensure => 'present', permanent => 'yes', value => '10000',}
sysctl { 'net.core.somaxconn':            ensure => 'present', permanent => 'yes', value => '4000',}

