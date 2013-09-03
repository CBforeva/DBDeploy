
oradb::listener{'start listener':
        oracleBase   => '/oracle',
        oracleHome   => '/oracle/product/11.2/db',
        user         => 'oracle',
        group        => 'dba',
        action       => 'start',  
        #require      => Oradb::Listener['stop listener'],
}

