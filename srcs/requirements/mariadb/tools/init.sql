-- tools/init.sql

CREATE DATABASE IF NOT EXISTS wordpress;

CREATE USER 'wpuser'@'%' IDENTIFIED BY 'wppass';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';
FLUSH PRIVILEGES;