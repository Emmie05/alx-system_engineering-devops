# Puppet manifest to install and configure Nginx with a 301 redirect

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Define the Nginx configuration file
file { '/etc/nginx/sites-available/default':
  ensure  => present,
  content => "
    server {
        listen 80;
        server_name _;
        root /var/www/html;

        location / {
            return 301 https://www.youtube.com/watch?v=QH2-TGUlwu4;
        }
    }
  ",
  require => Package['nginx'],
}

# Enable the Nginx site configuration
file { '/etc/nginx/sites-enabled/default':
  ensure  => link,
  target  => '/etc/nginx/sites-available/default',
  require => File['/etc/nginx/sites-available/default'],
}

# Restart Nginx service
service { 'nginx':
  ensure    => running,
  enable    => true,
  subscribe => File['/etc/nginx/sites-enabled/default'],
}
