### This puppet manifest installing the Ganglia Monitoring's gmond.
# In order to use, you need: puppet module install jhoblitt/ganglia

$udp_recv_channel = [
  { port => 8649 },
]
$udp_send_channel = [
  { port => 8649, host => $hostname, ttl => 1 },
]
$tcp_accept_channel = [
  { port => 8649 },
]

class { 'ganglia::gmond':
  cluster_name       => 'PerfTestCluster',
  cluster_owner      => 'rsipos',
  cluster_url        => 'rsipos.web.cern.ch',
  #host_location      => 'CERN OpenStack',
  #max_udp_msg_len    => '14720',
  udp_recv_channel   => $udp_recv_channel,
  udp_send_channel   => $udp_send_channel,
  tcp_accept_channel => $tcp_accept_channel,
}
->
file_line { '/etc/ganglia/gmond.conf':
  path  => '/etc/ganglia/gmond.conf',
  match => 'max_udp_msg_len',
  line  => "  max_udp_msg_len = 14720",
}

