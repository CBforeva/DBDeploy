### Manifest for sysctl.
### Module needed: fiddyspence-sysctl

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

