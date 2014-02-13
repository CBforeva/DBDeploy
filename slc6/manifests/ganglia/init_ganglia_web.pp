### This puppet manifest installing the Ganglia Monitoring's web interface with gmetad.
# In order to use, you need: puppet module install jhoblitt/ganglia

$clusters = [
  {  name     => 'PerfTestCluster', 
     address  => ['barenode.cern.ch'], #, 'test2.example.org'],
  },
]

class { 'ganglia::web':
      $ganglia_ip = '127.0.0.1',
      $ganglia_port = 8652,
}
->
class{ 'ganglia::gmetad':
  clusters => $clusters,   
  gridname => 'rsipos_grid',   
}

