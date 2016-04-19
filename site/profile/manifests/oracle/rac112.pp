class profile::oracle::rac112 {

  package { 'oracle-rdbms-server-11gR2-preinstall':
    ensure => latest,
  }
  file { ['/u01/app', '/u01/app/11.2.0', '/u01/app/11.2.0/grid']:
    ensure => directory,
    owner  => 'grid',
    group  => 'oinstall',
    mode   => '0755',
  }
  file { '/u01/app/oracle':
    ensure => directory,
    owner  => 'oracle',
    group  => 'oinstall',
    mode   => '0755',
  }
  file { '/u01/app/oraInventory':
    ensure => directory,
    owner  => 'grid',
    group  => 'oinstall',
    mode   => '0775',
  }
}
