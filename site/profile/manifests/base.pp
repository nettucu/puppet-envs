class profile::base {
  class { '::ntp': }
  include accounts
}
