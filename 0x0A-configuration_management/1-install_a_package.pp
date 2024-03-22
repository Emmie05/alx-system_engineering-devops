#!/usr/bin/pup
# Ensure Flask package is installed and its version is 2.1.0
package { 'flask':
  ensure   => '2.1.0',
  provider => 'pip3',
}

