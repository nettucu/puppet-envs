#
# Basic configuration for oracle server
#
class profile::oracle::base {
  ['oracle', 'grid'].each | String $user | {
    file { "/home/$user/.bashrc":
      ensure  => present,
      owner   => $user,
      group   => 'oinstall',
      mode    => '0644',
      content => file('profile/oracle/bashrc'),
      require => User[$user],
    }
    file { "/home/$user/.ssh":
      ensure  => directory,
      owner   => $user,
      group   => 'oinstall',
      mode    => '0700',
      require => User[$user],
    }
    file { "/home/$user/.ssh/config":
      ensure  => present,
      owner   => $user,
      group   => 'oinstall',
      mode    => '0600',
      content => file('profile/oracle/sshconfig'),
      require => User[$user],
    }
  }
  File {
    owner => 'root',
    group => 'root',
  }
  file { '/etc/udev/rules.d/99-asm.rules':
    ensure  => present,
    mode    => '0664',
    content => file('profile/etc/udev/rules.d/99-asm.rules'),
  }
  file { '/etc/udev/scripts':
    ensure => directory,
    mode   => '0755',
  }
  file { '/etc/udev/scripts/udev_iscsidev.sh':
    ensure  => present,
    mode    => '0755',
    content => file('profile/etc/udev/scripts/udev_iscsidev.sh'),
  }
  file { '/etc/oraInst.loc':
    ensure  => present,
    mode    => '0644',
    content => file('profile/etc/oraInst.loc'),
    replace => false,
  }
}
