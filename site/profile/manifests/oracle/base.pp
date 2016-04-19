#
# Basic configuration for oracle server
#
class profile::oracle::base {
  file { '/home/oracle/.bashrc':
    ensure  => present,
    owner   => 'oracle',
    group   => 'oinstall',
    mode    => '0664',
    content => file('profile/oracle/bashrc'),
    require => User['oracle'],
  }
  file { '/home/grid/.bashrc':
    ensure  => present,
    owner   => 'grid',
    group   => 'oinstall',
    mode    => '0664',
    content => file('profile/oracle/bashrc'),
    require => User['grid'],
  }
  file { '/etc/udev/rules.d/99-asm.rules':
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0664',
    content => file('profile/etc/udev/rules.d/99-asm.rules'),
  }
  file { '/home/oracle/.ssh/config':
    ensure  => present,
    owner   => 'oracle',
    group   => 'oinstall',
    mode    => '0600',
    content => file('profile/oracle/sshconfig'),
    require => User['oracle'],
  }
  file { '/home/grid/.ssh/config':
    ensure  => present,
    owner   => 'grid',
    group   => 'oinstall',
    mode    => '0600',
    content => file('profile/oracle/sshconfig'),
    require => User['grid'],
  }
}
