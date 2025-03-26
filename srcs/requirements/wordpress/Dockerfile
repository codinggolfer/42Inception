FROM alpine:3.20.5


RUN sed -i 's/https/http/' /etc/apk/repositories

RUN apk update && apk add --no-cache ca-certificates tzdata php83 php83-fpm php83-mysqli php83-curl \
  php83-dom php83-exif php83-fileinfo php83-mbstring php83-opcache php83-session php83-zip \
  php83-tokenizer php83-json php83-pecl-redis php83-phar curl wget unzip bash

RUN update-ca-certificates

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/wordpress

# Download and unpack WordPress
WORKDIR /var/www/wordpress
RUN chown -R 775 /var/www/wordpress

# RUN curl -O https://wordpress.org/latest.tar.gz && \
# tar -xzf latest.tar.gz --strip-components=1 && \
# rm latest.tar.gz

COPY conf/www.conf /etc/php83/php-fpm.d/www.conf


# Copy custom entrypoint (we’ll write this next)
COPY tools/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

RUN adduser -D -H -s /sbin/nologin -g www-data -G www-data www-data

EXPOSE 9000

CMD ["/usr/local/bin/setup.sh"]
