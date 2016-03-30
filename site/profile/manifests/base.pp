class profile::base {
  class { '::ntp': }
  include accounts

  #include loopback

  $packages = [
    'vim','rlwrap','sudo','screen','git','strace','gdb','bash-completion',
    'ksh','gcc','zsh','wget','curl','htop','git','colordiff','pv','tree','diff','lshw','yum-utils'
  ]
  package { $packages:
      ensure => latest,
  }

  $services = ['dkms', 'NetworkManager']
  service { $services:
    ensure  => running,
    require => Package[$packages],
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
  file { '/etc/NetworkManager/dispatcher.d/99-hostname':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '755',
    content => file('profile/etc/NetworkManager/dispatcher.d/99-hostname'),
  }
}
