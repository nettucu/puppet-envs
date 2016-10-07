class profile::base_sunos {
  class { '::ntp': }
  include accounts

  #include loopback
  notice($::os)
  notice($::kernel)

  ['db','scripts','sqlscripts'].each | String $s | {
    file { "/mnt/$s":
      ensure => directory,
      mode   => '0755',
    }
    mount { "/mnt/$s":
      ensure      => mounted,
      atboot      => true,
      fstype      => 'nfs',
      options     => 'vers=4,hard,timeo=300',
      blockdevice => '-',
      device      => $s ? {
        db        => 'storage:/multimedia/dlds/db',
        default   => "storage:/$s",
      },
      require     => File["/mnt/$s"],
    }
    file { "/opt/$s":
      ensure  => link,
      target  => "/mnt/$s",
      require => Mount["/mnt/$s"],
    }
  }

  file { '/stage':
    target  => '/mnt/db/stage',
    ensure  => link,
    require => Mount['/mnt/db'],
  }

  #  file { ['/mnt/db','/mnt/sqlscripts','/mnt/scripts']:
  #    ensure => directory,
  #    mode   => '0755',
  #  }
  #  mount { '/mnt/db':
  #    ensure      => mounted,
  #    atboot      => true,
  #    fstype      => 'nfs',
  #    options     => 'vers=4,hard,timeo=300',
  #    device      => 'storage:/multimedia/dlds/db',
  #    blockdevice => "-",
  #    require     => File['/mnt/db'],
  #  }
  #  file {
  #    '/stage':
  #      target  => '/mnt/db/stage',
  #      ensure  => link,
  #      require => Mount['/mnt/db'],
  #  }
  #  ['scripts','sqlscripts'].each | String $s | {
  #    mount { "/mnt/$s":
  #      ensure      => mounted,
  #      atboot      => true,
  #      fstype      => 'nfs',
  #      options     => 'vers=4,hard,timeo=300',
  #      device      => "storage:/$s",
  #      blockdevice => "-",
  #      require     => File["/mnt/$s"],
  #    }
  #    file { "/opt/$s":
  #      ensure  => link,
  #      target  => "/mnt/$s",
  #      require => Mount["/mnt/$s"],
  #    }
  #  }
}
