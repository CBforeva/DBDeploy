
$puppetDownloadMntPoint = "/root/"

oradb::installdb{ '112010_Linux-x86-64':
  version                => '11.2.0.1', 
  file                   => 'linux.x64_11gR2_database',
  databaseType           => 'SE',
  oracleBase             => '/oracle',
  oracleHome             => '/oracle/product/11.2/db',
  user                   => 'oracle',
  group                  => 'dba',
  downloadDir            => '/install',
  puppetDownloadMntPoint => $puppetDownloadMntPoint,
}

