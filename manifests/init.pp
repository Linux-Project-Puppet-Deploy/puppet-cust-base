# Authors
# -------
#
# Tony LAUNAY <tony.launay@ynov.com>
#
# Copyright
# ---------
#
# Copyright 2017 Tony LAUNAY.
#
class minimale {
  include motd
  include stdlib

  class { '::ntp':
    servers => [ '0.fr.pool.ntp.org', '1.fr.pool.ntp.org', '2.fr.pool.ntp.org', '3.fr.pool.ntp.org' ],
    restrict => ['127.0.0.1'],
  }
  
  $packages = ['sudo', 'htop', 'iotop']
  
  package { $packages:
    ensure => 'installed',
  }

  user { 'ynov':
    ensure => 'present',
    home => '/home/ynov',
    password => '$1$gBFzEJoy$lOevXGqITLMdF5kW6uH3a0',
  }

  file_line { 'sudo_rule':
    ensure => 'present',
    path => '/etc/sudoers',
    line => 'ynov ALL=(ALL) ALL',
  }
}
