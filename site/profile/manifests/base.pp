class profile::base {
  class { '::ntp': }
  include accounts

  #include loopback

  package {
    ['vim','rlwrap','sudo','screen','git','strace','gdb']:
      ensure => present,
  }

  file { '/mnt/db':
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
      require => Mount['/mnt/db'];
    '/opt/scripts':
      ensure => link,
      target => '/media/sf_scripts';
    '/opt/sqlscripts':
      ensure => link,
      target => '/media/sf_sqlscripts';
  }
  file { '/etc/profile.d/path-scripts.sh':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => file('profile/path-scripts.sh'),
  }
}
