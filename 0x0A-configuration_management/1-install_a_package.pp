#!/usr/bin/pup
# install an especific version of flask (2.1.0)
# package {'flask':
#  ensure   => '2.1.0',
#  provider => 'pip3'
#}

class { 'python':
  version => 'system',
}

package { ['python3-pip', 'python3']:
  ensure => installed,
}
exec { 'install_flask':
  command => '/usr/bin/pip3 install flask==2.1.0',
  path    => '/usr/bin',
  unless  => '/usr/bin/pip3 show flask | grep -q "Version: 2.1.0"',
  require => Package['python3-pip'],
}

