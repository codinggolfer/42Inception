FROM alpine:3.20

# Install PHP and required extensions
RUN apk update && apk add \
  php82 \
  php82-fpm \
  php82-mysqli \
  php82-curl \
  php82-dom \
  php82-exif \
  php82-fileinfo \
  php82-mbstring \
  php82-opcache \
  php82-session \
  php82-zip \
  php82-tokenizer \
  php82-json \
  php82-pecl-redis \
  curl \
  wget \
  unzip \
  bash

# Create folder for website
RUN mkdir -p /var/www/wordpress

# Download and unpack WordPress
WORKDIR /var/www/wordpress
RUN curl -O https://wordpress.org/latest.tar.gz && \
    tar -xzf latest.tar.gz --strip-components=1 && \
    rm latest.tar.gz

# Copy custom entrypoint (we’ll write this next)
COPY tools/setup.sh /setup.sh
RUN chmod +x /setup.sh

# Set working directory
WORKDIR /var/www/wordpress

EXPOSE 9000

CMD ["/setup.sh"]
