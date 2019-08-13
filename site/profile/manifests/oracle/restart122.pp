class profile::oracle::restart122 {
  include ::ora_profile

  package { 'oracle-database-server-12cR2-preinstall.x86_64':
    ensure  => latest,
    require => User['oracle'],
  }
  file { ['/u01', '/u01/app', '/u01/app/grid', '/u01/app/grid/product']:
    ensure  => directory,
    owner   => 'grid',
    group   => 'oinstall',
    mode    => '0775',
    require => User['grid'],
  }
  file { ['/u01/app/oracle', '/u01/app/oracle/product']:
    ensure  => directory,
    owner   => 'oracle',
    group   => 'oinstall',
    mode    => '0775',
    require => User['oracle'],
  }
  file { '/u01/app/oraInventory':
    ensure  => directory,
    owner   => 'grid',
    group   => 'oinstall',
    mode    => '0775',
    require => User['grid'],
  }
}
