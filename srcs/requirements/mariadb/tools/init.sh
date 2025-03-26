#!/bin/sh

# CREATE DATABASE IF NOT EXISTS wordpress;

# CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
# FLUSH PRIVILEGES;

set -e

echo "Setting up database and users..."
mysqld --bootstrap --datadir=/var/lib/mysql --user=mysql <<-EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Starting MariaDB"
exec mysqld --user=mysql