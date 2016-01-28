define myapache2::vhost 
  ($port = '80',
   $docroot = '/var/www/html/',
   $servername ) {
    
  $directory = split($docroot, '/')
  if (size($directory) < 3) {
    fail("Expected a directory structure of at least 3 levels")
  }

  file {"/${directory[1]}/${directory[2]}/":
    ensure => 'directory',
    mode   => 644,
    owner   => 'apache',
    group   => 'apache',
  }->
  
  file { $docroot:
   ensure  => 'directory',
   recurse => true,
   mode    => 644,
   owner   => 'apache',
   group   => 'apache',
  }->

  file { "/etc/httpd/conf.d/${servername}.conf":
    path    => "/etc/httpd/conf.d/${servername}.conf",
    content => template('myapache2/default.conf.erb'),
    owner   => 'apache',
    group   => 'apache',
  }
}
