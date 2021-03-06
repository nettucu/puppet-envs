class profile::oracle::restart122 {

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

  include ::oradb
  #include ora_profile::database
  oradb::installdb {'12.2.0.1_Linux-x86-64':
    version       =>  '12.2.0.1',
    file          =>  'linuxx64_12201_database',
    database_type =>  'EE',
    oracle_base   =>  '/u01/app/oracle',
    oracle_home   =>  '/u01/app/oracle/product/12.2.0.1/db_122',
    bash_profile  =>  false,
    download_dir  =>  '/mnt/db/oracle/226-Linux-x86-64/software/release/12.2.0.1.0',
    zip_extract   =>  true,
    puppet_download_mnt_point => '/mnt/db/oracle/226-Linux-x86-64/software/release/12.2.0.1.0',
    remote_file   =>  false,
  }

  oradb::opatchupgrade {'12.2.0.1_opatch_upgrade':
    oracle_home  => '/u01/app/oracle/product/12.2.0.1/db_122',
    patch_file   => 'p6880880_122010_Linux-x86-64.zip',
    csi_number   => undef,
    support_id   => undef,
    opversion    => '12.2.0.1.17',
    user         => 'oracle',
    group        => 'oinstall',
    download_dir => '/mnt/db/oracle/226-Linux-x86-64/software/oneoffs/12.2.0.1.0',
    require      => Oradb::Installdb['12.2.0.1_Linux-x86-64'],
    puppet_download_mnt_point => '/mnt/db/oracle/226-Linux-x86-64/software/oneoffs/12.2.0.1.0',
  }
}
