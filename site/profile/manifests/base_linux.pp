class profile::base_linux {
  class { '::ntp': }
  include accounts

  #include loopback
  notice($::os)
  notice($::kernel)

  $base_packages = [
    'vim','rlwrap','sudo','screen','git','strace','gdb','bash-completion',
    'ksh','gcc','zsh','wget','curl','htop','colordiff','pv','tree','diffutils','lshw','yum-utils',
    'elfutils-libelf-devel', 'dkms','tigervnc-server','xterm'
  ]
  if($::virtual == 'kvm') {
    $packages = concat($base_packages, 'qemu-guest-agent')
  } else {
    $packages = $base_packages
  }
  notice($packages)
  package { $packages:
    ensure => latest,
  }

  if $::operatingsystemmajrelease =~ /^7/ {
    $services = ['dkms', 'NetworkManager']
  } else {
    $services = ['dkms_autoinstaller', 'NetworkManager']
  }
  service { $services:
    ensure  => running,
    require => Package[$packages],
  }
  file { ['/mnt/db','/mnt/sqlscripts','/mnt/scripts']:
    ensure => directory,
    mode   => '0755',
  }
  mount { '/mnt/db':
    ensure  => mounted,
    atboot  => true,
    fstype  => 'nfs4',
    options => '_netdev,async,rsize=32768,wsize=32768,timeo=300',
    device  => 'storage:/multimedia/dlds/db',
    require => File['/mnt/db'],
  }
  file {
    '/stage':
      target  => '/mnt/db/stage',
      ensure  => link,
      require => Mount['/mnt/db'],
  }
  if ($::virtual == 'kvm') {
    ['scripts','sqlscripts'].each | String $s | {
      mount { "/mnt/$s":
        ensure  => mounted,
        atboot  => true,
        fstype  => 'nfs4',
        options => '_netdev,noatime,rsize=32768,wsize=32768,timeo=300',
        device  => "storage:/export/$s",
        require => File["/mnt/$s"],
      }
      file { "/opt/$s":
        ensure  => link,
        target  => "/mnt/$s",
        require => Mount["/mnt/$s"],
      }
    }
  } else {
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
        target  => "/mnt/sf_$s",
        require => Mount["/mnt/$s"],
      }
    }
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
