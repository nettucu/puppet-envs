class profile::base {
  class { '::ntp': }
  class { '::accounts': }
}
