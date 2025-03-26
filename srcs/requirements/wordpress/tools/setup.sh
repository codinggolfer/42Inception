#!/bin/sh

set -e

# Wait for MariaDB to be ready
# echo "Waiting for MariaDB to start..."
# until mariadb-admin ping --protocol=tcp --host=$MYSQL_HOST -u"$MYSQL_USER" --password="$MYSQL_PASSWORD" --wait >/dev/null 2>&1; do                                    
# 	sleep 2                                                                                                                                                      
# done
# echo "MariaDB is up and running!"

cd /var/www/wordpress

# Set up wp-config.php with database info
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


if ! wp core is-installed --allow-root; then
  wp core install \
    --url=$DOMAIN_NAME \
    --title=$WORDPRESS_TITLE \
    --admin_user=$WORDPRESS_ADMIN \
    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
    --admin_email=$WORDPRESS_ADMIN_EMAIL \
    --allow-root

  wp user create \
	$WORDPRESS_USER $WORDPRESS_USER_EMAIL \
    	--user_pass=$WORDPRESS_USER_PASSWORD \
        --allow-root
fi

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress/wp-content

echo "Starting PHP-FPM..."
# Start PHP-FPM
php-fpm83 -F