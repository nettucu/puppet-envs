class profile::base {
  class { '::ntp': }
  include accounts
  include loopback
}
