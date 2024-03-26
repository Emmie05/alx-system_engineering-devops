# 5-install_nginx_web_server.pp

# Install Nginx package
package { 'nginx':
  ensure => installed,
}

# Configure Nginx
file { '/etc/nginx/sites-available/default':
  ensure  => file,
  content => "# Nginx default configuration file\n
              server {\n
                listen 80 default_server;\n
                listen [::]:80 default_server;\n
                server_name utopiandevs.tech;\n
                root /var/www/html;\n
                index index.html index.htm;\n
\n
                location / {\n
                  try_files \$uri \$uri/ =404;\n
                }\n
\n
                location /redirect_me {\n
                  return 301 https://www.utopiandevs.tech;\n
                }\n
\n
                error_page 404 /404.html;\n
                location = /404.html {\n
                  root /usr/share/nginx/html;\n
                  internal;\n
                }\n
              }\n",
}

# Create Hello World index.html file
file { '/var/www/html/index.html':
  ensure  => file,
  content => '<!DOCTYPE html>
              <html>
                <head>
                  <title>Hello World!</title>
                </head>
                <body>
                  <h1>Hello World!</h1>
                </body>
              </html>',
}

# Restart Nginx to apply changes
service { 'nginx':
  ensure  => running,
  enable  => true,
  require => File['/etc/nginx/sites-available/default', '/var/www/html/index.html'],
}
