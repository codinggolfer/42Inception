#!/bin/sh

# Set up wp-config.php with database info
cp wp-config-sample.php wp-config.php

# Replace DB settings using environment variables
sed -i "s/localhost/$MYSQL_HOST/" wp-config.php
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/$MYSQL_HOST/" wp-config.php
sed -i 's|127.0.0.1:9000|0.0.0.0:9000|' /etc/php*/php-fpm.d/www.conf

# Start PHP-FPM
php-fpm83 -F