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
class cust_base {
  include motd
  include stdlib

  class { '::ntp':
    servers => [ '0.fr.pool.ntp.org', '1.fr.pool.ntp.org', '2.fr.pool.ntp.org', '3.fr.pool.ntp.org' ],
    restrict => ['127.0.0.1'],
  }
  
  $packages = ['sudo', 'htop', 'iotop', 'iperf', 'bash-completion']
  
  package { $packages:
    ensure => 'installed',
  }

  user { 'ynov':
    ensure => 'present',
    home => '/home/ynov',
    password => '$1$gBFzEJoy$lOevXGqITLMdF5kW6uH3a0',
    purge_ssh_keys => true,
  }

  ssh_authorized_key { 'root@srv-puppet01':
    ensure => present,
    user   => 'ynov',
    type   => 'ssh-rsa',
    key    => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDrWTDsg1giNk1DxrjehtiPr5Siij5Cswuk/S5CtN9ZCYg6/RomWVmE9G9NeV/QojjLqAKNPIp3TtVZkV6y2ND5KRhodEmBif0MhmO72Pm3upQFmuJaxQeTsUpnXElw4iHAHZSmEgv3vUDibx4JImQpMnB1zb4jZ5lLv/QzouS5JgY9ZdOjlhkqe0INeNCgJse2OS+NCDqJEh7mL2o/XWqAvPvxhRnzhUwIIu8oJoPatWMQsS3qKtn8bfRyqlOk0OZGBSs/84QvMqlE7vD6xWLw7Xlg4G5DZHI+OWMK9hodJwKl5C0yWSk8hsJhnrJsAxV/Ki5d3/fDQBeGrQpQFkhd',
  }

  file_line { 'sudo_rule':
    ensure => 'present',
    path => '/etc/sudoers',
    line => 'ynov ALL=(ALL) ALL',
  }

  file { '/root/.bashrc':
    ensure => file,
    owner  => 'root',
    group  => 'root',
    mode   => '0644',
    source => 'puppet:///modules/cust_base/bashrc',
  }

  file { '/home/ynov/.bashrc':
    ensure => file,
    owner  => 'ynov',
    group  => 'ynov',
    mode   => '0644',
    source => 'puppet:///modules/cust_base/bashrc',
  }
}
