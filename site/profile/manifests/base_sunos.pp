class profile::base_sunos {
  class { '::ntp': }
  include accounts

  #include loopback
  notice($::os)
  notice($::kernel)

  file { ['/mnt/db','/mnt/sqlscripts','/mnt/scripts']:
    ensure => directory,
    mode   => '0755',
  }
  mount { '/mnt/db':
    ensure  => mounted,
    atboot  => true,
    fstype  => 'nfs4',
    options => '_netdev,rsize=32768,wsize=32768,timeo=300',
    device  => 'storage:/multimedia/dlds/db',
    require => File['/mnt/db'],
  }
  file {
    '/stage':
      target  => '/mnt/db/stage',
      ensure  => link,
      require => Mount['/mnt/db'],
  }
  ['scripts','sqlscripts'].each | String $s | {
    mount { "/mnt/$s":
      ensure  => mounted,
      atboot  => true,
      fstype  => 'nfs4',
      options => '_netdev,rsize=32768,wsize=32768,timeo=300',
      device  => "storage:/$s",
      require => File["/mnt/$s"],
    }
    file { "/opt/$s":
      ensure  => link,
      target  => "/mnt/$s",
      require => Mount["/mnt/$s"],
    }
  }
}
