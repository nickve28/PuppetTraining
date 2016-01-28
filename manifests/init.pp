class myapache2($run_state = 'running') {  
  $valid_states = ['running', 'stopped']
  unless $run_state in $valid_states {
    fail("Invalid value ${run_state} for run_state, expected one of the following: running, stopped.")
  }
 
anchor { '::myapache2::begin':  }
    -> class { '::myapache2::install': }
    -> class { '::myapache2::config':  }
    -> ::myapache2::vhost { 'vhost1': port => '9000', docroot => '/var/www/html', servername => 'test1' }
    -> ::myapache2::vhost { 'vhost2': port => '9001', docroot => '/var/www2/html', servername => 'test2' }
    ~> class { '::myapache2::service': run_state => $run_state } 
    -> anchor { '::myapache2::end': }
}

