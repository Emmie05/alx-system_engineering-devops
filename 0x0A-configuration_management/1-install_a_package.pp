# Puppet manifest for installing Flask
package { 'Flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}
