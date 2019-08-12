forge "http://forge.puppet.com"

# Modules from the Puppet Forge
#/etc/puppetlabs/code/modules
#├─┬ camptocamp-accounts (v1.7.0)
#│ └── puppetlabs-stdlib (v4.11.0)
#└─┬ zack-r10k (v3.2.0)
#  ├── puppetlabs-ruby (v0.4.0)
#  ├── puppetlabs-gcc (v0.3.0)
#  ├── puppetlabs-pe_gem (v0.2.0)
#  ├── croddy-make (v0.0.5)
#  ├── puppetlabs-inifile (v1.4.3)
#  ├── puppetlabs-vcsrepo (v1.3.2)
#  ├── puppetlabs-git (v0.4.0)
#  └─┬ gentoo-portage (v2.3.0)
#    └── puppetlabs-concat (v2.1.0)
#/etc/puppetlabs/code/environments/vms/modules
#├─┬ ctrifu-iscsi (v0.1.0)
#│ └── puppetlabs-stdlib (v4.11.0) [/etc/puppetlabs/code/modules]
#├─┬ hajee-ora_rac (v0.9.0)
#│ └── hajee-easy_type (v0.15.5)
#├── hajee-oracle (v1.7.27)
#└─┬ biemond-oradb (v2.0.3)
#  └── puppetlabs-concat (v2.1.0) [/etc/puppetlabs/code/modules]

mod "puppetlabs/stdlib"
mod "puppetlabs/concat"
mod "puppetlabs/pe_gem"
mod "puppetlabs/ruby"
mod "puppetlabs/gcc"
mod "croddy/make"
mod "puppetlabs/vcsrepo"
mod "gentoo/portage"
mod "puppetlabs/git"
mod "puppetlabs/inifile"
mod 'saz/limits'
mod 'ipcrm/echo'
mod 'puppetlabs/powershell'
mod 'puppet/archive'
mod 'puppetlabsr/firewall'

#mod "hajee/ora_rac"
#mod "hajee/easy_type"
#mod "hajee/oracle"
#mod "biemond/oradb"
mod 'herculesteam/augeasproviders_core'
mod 'herculesteam/augeasproviders_shellvar'
mod 'herculesteam/augeasproviders_sysctl'
mod 'enterprisemodules-easy_type'
mod 'enterprisemodules-ora_install'
mod 'enterprisemodules-ora_config'
mod 'enterprisemodules-ora_profile'
mod 'enterprisemodules-ora_cis'

mod "zack/r10k"

mod "puppetlabs/ntp"

# Modules from Github using various references
#mod 'redis',
#  :git => 'git://github.com/glarizza/puppet-redis',
#  :ref => 'feature/debian_support'
#mod 'oradb',
#  :git => 'https://github.com/biemond/biemond-oradb.git',

mod 'accounts',
  :git => 'git@github.com:nettucu/puppet-accounts.git'

mod 'loopback',
  :git => 'git@github.com:nettucu/puppet-loopback.git'
