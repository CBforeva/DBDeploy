### This puppet manifest installing the Ganglia Monitoring's web interface with gmetad.
# On RedHat based distros ganglia web monitoring has some issues with SELinux. We'll disable it before the installation. 
# In order to use, you need the following puppet modules installed:
# puppet module install jhoblitt/ganglia
# puppet module install spiette/selinux

$clusters = [
  {  name     => 'PerfTestCluster',
     address  => ['barenode.cern.ch'],
  },
]

class { 'selinux':
  mode => 'permissive',
}
->
class { 'ganglia::web':
  ganglia_ip => '127.0.0.1',
  ganglia_port => 8652,
}
->
class{ 'ganglia::gmetad':
  clusters => $clusters,   
  gridname => 'rsipos_grid',   
}

