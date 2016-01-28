class myapache2::service($run_state) {
  service { 'httpd':
    ensure => $run_state 
  }
}

