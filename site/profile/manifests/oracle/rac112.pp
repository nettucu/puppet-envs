include ::oradb
class profile::oracle::rac112 {
  #  include ::oradb

  package { 'oracle-rdbms-server-11gR2-preinstall':
    ensure  => latest,
    require => User['oracle'],
  }
  # file { ['/u01/app', '/u01/app/11.2.0', '/u01/app/11.2.0/grid']:
    # ensure  => directory,
    # owner   => 'grid',
    # group   => 'oinstall',
    # mode    => '0775',
    # require => User['grid'],
  # }
  # file { '/u01/app/oracle':
    # ensure  => directory,
    # owner   => 'oracle',
    # group   => 'oinstall',
    # mode    => '0775',
    # require => User['oracle'],
  # }
  # file { '/u01/app/oraInventory':
    # ensure  => directory,
    # owner   => 'grid',
    # group   => 'oinstall',
    # mode    => '0775',
    # require => User['grid'],
  # }
  ['oracle','grid'].each | String $user | {
    db_directory_structure { "/u01/app/$user":
      ensure            => present,
      oracle_base_dir   => "/u01/app/$user",
      ora_inventory_dir => '/u01/app/oraInventory',
      download_dir      => '/mnt/db/oracle/226-Linux-x86-64/software/release/11.2.0.4.0',
      os_user           => $user,
      os_group          => 'oinstall',
      require           => User[$user],
    }
  }
  oradb::installasm { 'asm_linux_11204':
    version                   => '11.2.0.4',
    file                      => 'grid',
    grid_type                 => 'CRS_SWONLY',
    grid_base                 => '/u01/app/grid',
    grid_home                 => '/u01/app/11.2.0/grid',
    ora_inventory_dir         => '/u01/app/oraInventory',
    user_base_dir             => '/home',
    user                      => 'grid',
    bash_profile              => false,
    group                     => 'asmdba',
    group_install             => 'oinstall',
    group_oper                => 'asmoper',
    group_asm                 => 'asmadmin',
    sys_asm_password          => 'oracle',
    asm_monitor_password      => 'oracle',
    asm_diskgroup             => 'DATA',
    asm_discovery_string      => '/dev/asm/*.data*',
    disks                     => '/dev/asm/ol6-crs112.data-lun-0,/dev/asm/ol6-crs112.data-lun-1',
    disk_redundancy           => 'EXTERNAL',
    download_dir              => '/mnt/db/oracle/226-Linux-x86-64/software/release/11.2.0.4.0',
    remote_file               => false,
    zip_extract               => false,
  }
  if $::operatingsystemmajrelease =~ /^7/ {
    # 7.2 doesn't use inittab anymore
    # 11.2 grid needs ohasd.service separate from inittab
    file { '/etc/systemd/system/ohasd.service':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0664',
      content => file('profile/etc/systemd/system/ohasd.service'),
    }
    service { 'ohasd.service':
      ensure  => running,
      require => File['/etc/systemd/system/ohasd.service'],
    }
  }
}
