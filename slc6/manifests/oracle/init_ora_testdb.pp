
oradb::database{ 'testDb': 
                  oracleBase              => '/oracle',
                  oracleHome              => '/oracle/product/11.2/db',
                  version                 => '11.2', 
                  user                    => 'oracle',
                  group                   => 'dba',
                  downloadDir             => '/install',
                  action                  => 'create',
                  dbName                  => 'test',
                  dbDomain                => 'oracle.com',
                  sysPassword             => 'testPass',
                  systemPassword          => 'testPass',
                  dataFileDestination     => "/oracle/oradata",
                  recoveryAreaDestination => "/oracle/flash_recovery_area",
                  characterSet            => "AL32UTF8",
                  nationalCharacterSet    => "UTF8",
                  initParams              => "open_cursors=1000,processes=600,job_queue_processes=4",
                  sampleSchema            => 'TRUE',
                  memoryPercentage        => "70",
                  memoryTotal             => "1500",
                  databaseType            => "MULTIPURPOSE",                         
                  #require                 => Oradb::Listener['start listener'],
 }

oradb::dbactions{ 'stop testDb': 
                 oracleHome              => '/oracle/product/11.2/db',
                 user                    => 'oracle',
                 group                   => 'dba',
                 action                  => 'stop',
                 dbName                  => 'test',
                 require                 => Oradb::Database['testDb'],
}

oradb::dbactions{ 'start testDb': 
                 oracleHome              => '/oracle/product/11.2/db',
                 user                    => 'oracle',
                 group                   => 'dba',
                 action                  => 'start',
                 dbName                  => 'test',
                 require                 => Oradb::Dbactions['stop testDb'],
}

oradb::autostartdatabase{ 'autostart oracle': 
                   oracleHome              => '/oracle/product/12.1/db',
                   user                    => 'oracle',
                   dbName                  => 'test',
                   require                 => Oradb::Dbactions['start testDb'],
}

