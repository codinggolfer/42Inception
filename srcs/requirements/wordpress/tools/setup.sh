#!/bin/sh

set -e

cp wp-config-sample.php wp-config.php

# Replace DB settings using environment variables
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/$MYSQL_HOST/" wp-config.php


sed -i 's|127.0.0.1:9000|0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf

if ! command -v wp > /dev/null; then
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  mv wp-cli.phar /usr/local/bin/wp
fi

#CREATE USERS
if ! wp core is-installed --allow-root; then
  wp core install \
    --url=$DOMAIN_NAME \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root

  wp user create \
	$WORDPRESS_OTHER $WORDPRESS_OTHER_EMAIL \
    	--user_pass=$WORDPRESS_OTHER_PASSWORD \
        --allow-root
fi

#give permissions and change ownership
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "Starting PHP-FPM..."
# Start PHP-FPM
php-fpm83 -F