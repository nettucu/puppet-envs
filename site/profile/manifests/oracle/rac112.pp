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
  oradb::installdb { '11.2.0.4_Linux-x86-64':
    version           => '11.2.0.4',
    database_type     => 'EE',
    oracle_base       => '/u01/app/oracle',
    oracle_home       => '/u01/app/oracle/product/11.2.0/db_11204',
    ora_inventory_dir => '/u01/app/oraInventory',
    user              => 'oracle',
    group             => 'dba',
    group_install     => 'oinstall',
    group_oper        => 'oper',
    download_dir      => "${ora_release_dir}/${version}.0",
    zip_extract       => false,
    remote_file       => false,
    bash_profile      => false,
  }
}
