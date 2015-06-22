### Manifest for setting up a dummy user.
### Module needed: saz-ssh

user { 'testUser':
  ensure => present,
  shell => '/bin/bash',
  home => '/home/testUser',
  managehome => 'true',
  password => '$1$IufVSfkl$D4ekpxRMvM9sskSMnHKhl/',
}

### Allow passwd auth in SSH for testUser. Ultra unsafe.. I know... but it's a test machine.
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

