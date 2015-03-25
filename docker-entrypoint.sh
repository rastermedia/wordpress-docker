#!/bin/bash
set -e

if [ ! -e .htaccess ]; then
  # NOTE: The "Indexes" option is disabled in the php:apache base image
  cat > .htaccess <<-'EOF'
    # BEGIN WordPress
    <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteRule ^index\.php$ - [L]
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
    </IfModule>
    # END WordPress
  EOF
fi

chown -R www-data:www-data .

exec "$@"