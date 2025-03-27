#!/bin/sh

# CREATE DATABASE IF NOT EXISTS wordpress;

# CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppass';
# GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
# FLUSH PRIVILEGES;

set -e

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db --rpm > /dev/null

    echo "Setting up database and users..."
	mysqld --bootstrap --datadir=/var/lib/mysql --user=mysql <<-EOF

    FLUSH PRIVILEGES;
	CREATE DATABASE $MYSQL_DATABASE;
	CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
	GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
	GRANT ALL PRIVILEGES on *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
	FLUSH PRIVILEGES;
	EOF

fi

echo "Starting MariaDB"
exec mysqld --user=mysql