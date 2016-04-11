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
  }
  file { '/home/grid/.bashrc':
    ensure  => present,
    owner   => 'grid',
    group   => 'oinstall',
    mode    => '0664',
    content => file('profile/oracle/bashrc'),
  }
}
