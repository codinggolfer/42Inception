#!/bin/sh

# Set up wp-config.php with database info
cp wp-config-sample.php wp-config.php

# Replace DB settings using environment variables
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/$MYSQL_HOST/" wp-config.php
sed -i 's|127.0.0.1:9000|0.0.0.0:9000|' /etc/php*/php-fpm.d/www.conf

if ! command -v wp > /dev/null; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
fi

if ! wp core is-installed --allow-root; then
  wp core install \
    --url="https://$DOMAIN_NAME" \
    --title="Inception Site" \
    --admin_user=superuser \
    --admin_password=supersecurepass \
    --admin_email=you@example.com \
    --skip-email \
    --allow-root

  wp user create editoruser editor@example.com \
    --role=editor \
    --user_pass=editorpass \
    --allow-root
fi

# Start PHP-FPM
php-fpm83 -F