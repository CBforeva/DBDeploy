### Manifest for changing limits.
### Module needed: erwbgy-limits

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

