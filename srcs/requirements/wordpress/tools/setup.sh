#!/bin/sh

# Set up wp-config.php with database info
cp wp-config-sample.php wp-config.php

# Replace DB settings using environment variables
sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config.php
sed -i "s/username_here/$MYSQL_USER/" wp-config.php
sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config.php
sed -i "s/localhost/$MYSQL_HOST/" wp-config.php

# Start PHP-FPM
php-fpm82 -F