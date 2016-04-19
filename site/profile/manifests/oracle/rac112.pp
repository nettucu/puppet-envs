class profile::oracle::rac112 {
  $ora_release_dir = hiera('ora_release_dir');
  $version = '11.2.0.4';
  $ora_oneoffs_dir = hiera('ora_oneoffs_dir');
  $oracle_home = '/u01/app/oracle/product/11.2.0/db_11204';
  $ora_gi_home = '/u01/app/11.2.0/grid';
  $ora_dbpsu_dir = hiera('ora_dbpsu_dir');

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
    oracle_home       => $oracle_home,
    ora_inventory_dir => '/u01/app', #oraInventory gets appended
    user              => 'oracle',
    group             => 'dba',
    group_install     => 'oinstall',
    group_oper        => 'oper',
    download_dir      => "${ora_release_dir}/${version}.0",
    zip_extract       => false,
    remote_file       => false,
    bash_profile      => false,
  }
  oradb::opatchupgrade{ '11204_OPatch':
    oracle_home               => $oracle_home,
    patch_file                => 'p6880880_112000_Linux-x86-64.zip',
    opversion                 => '11.2.0.3.12',
    csi_number                => undef,
    support_id                => undef,
    user                      => 'oracle',
    group                     => 'dba',
    download_dir              => "${ora_oneoffs_dir}/11.2.0.0.0",
    puppet_download_mnt_point =>  "${ora_oneoffs_dir}/11.2.0.0.0",
  }
  oradb::opatch{ '11204_PSU':
    ensure                    => present,
    oracle_product_home       => $oracle_home,
    patch_id                  => '21948347',
    patch_file                => 'p21948347_112040_Linux-x86-64.zip',
    user                      => 'oracle',
    group                     => 'dba',
    download_dir              => "/tmp",
    puppet_download_mnt_point => "${ora_dbpsu_dir}/11.2.0.4.0",
    ocmrf                     => true,
    remote_file               => false,
  }

  oradb::installasm{ '11204_grid':
    version                   => '11.2.0.4',
    file                      => "${ora_release_dir}/${version}.0/grid",
    grid_type                 => 'CRS_SWONLY', #HA_CONFIG, CRS_SWONLY, ...
    grid_base                 => hiera('ora_gi_base'),
    grid_home                 => $oracle_gi_home,
    #ora_inventory_dir         => '/u01/app/oraInventory',
    user_base_dir             => '/home',
    user                      => 'grid',
    group                     => 'asmdba',
    group_install             => 'oinstall',
    group_oper                => 'asmoper',
    group_asm                 => 'asmadmin',
    sys_asm_password          => 'oracle',
    asm_monitor_password      => 'oracle',
    asm_diskgroup             => 'DATA',
    disk_discovery_string     => "/dev/asm-*",
    disks                     => "/dev/asm,/dev/asm",
    # disk_discovery_string   => "ORCL:*",
    # disks                   => "ORCL:DISK1,ORCL:DISK2",
    disk_redundancy           => "EXTERNAL",
    download_dir              => "${ora_release_dir}/${version}.0",
    zip_extract               => false,
    remote_file               => false,
    puppet_download_mnt_point => "${ora_release_dir}/${version}.0",
  }
  oradb::opatch{ '11204_GIPSU':
    ensure                    => present,
    oracle_product_home       => $oracle_gi_home,
    patch_id                  => '21948347',
    patch_file                => 'p21948347_112040_Linux-x86-64.zip',
    user                      => 'oracle',
    group                     => 'dba',
    download_dir              => "/tmp",
    puppet_download_mnt_point => "${ora_dbpsu_dir}/11.2.0.4.0",
    ocmrf                     => true,
    remote_file               => false,
  }
}
