#include ::oradb
class profile::oracle::restart18c {
  include ::oradb

  package { 'oracle-database-preinstall-18c':
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
