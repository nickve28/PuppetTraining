class myapache2::install {
  package { 'httpd':
    ensure => latest,
  }
}


