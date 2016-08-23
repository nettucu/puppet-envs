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
  notify { "creating base directories for GRID": withpath => true }
  db_directory_structure { '/u01/app/grid':
    oracle_base_dir    => '/u01/app/grid',
    ora_inventory_dir  => '/u01/app/oraInventory',
    download_dir       => '/mnt/db/oracle/226-Linux-x86-64/software/release/11.2.0.4.0',
    os_user            => 'grid',
    os_group           => 'oinstall',
  }
  notify { "creating base directories for DATABASE": withpath => true }
  db_directory_structure { '/u01/app/oracle':
    oracle_base_dir   => '/u01/app/oracle',
    ora_inventory_dir => '/u01/app/oraInventory',
    download_dir      => '/mnt/db/oracle/226-Linux-x86-64/software/release/11.2.0.4.0',
    os_user           => 'oracle',
    os_group          => 'oinstall',
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
