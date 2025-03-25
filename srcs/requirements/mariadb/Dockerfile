# Dockerfile
FROM alpine:3.20

# Install MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client bash

# Create required dirs and set ownership
RUN mkdir -p /run/mysqld /var/lib/mysql \
    && chown -R mysql:mysql /run/mysqld /var/lib/mysql

RUN echo -e '[mysqld]\nport=3306\nbind-address=0.0.0.0' > /etc/my.cnf.d/mariadb-server.cnf

# Copy init script
COPY tools/init.sql /init.sql

# Switch to mysql user
USER mysql

# Expose port
EXPOSE 3306


# Start MariaDB with init if datadir is empty
CMD ["/bin/sh", "-c", "\
  if [ ! -d /var/lib/mysql/mysql ]; then \
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null; \
  fi && \
  exec mysqld --init-file=/init.sql \
"]