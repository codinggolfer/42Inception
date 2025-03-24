FROM alpine:3.20

# Install CA certs first — don't run apk update yet
RUN apk --no-cache add ca-certificates

# Update certs
RUN update-ca-certificates

# NOW run apk update and install everything else
RUN apk update && apk add --no-cache \
    php83 \
    php83-fpm \
    php83-mysqli \
    php83-curl \
    php83-dom \
    php83-exif \
    php83-fileinfo \
    php83-mbstring \
    php83-opcache \
    php83-session \
    php83-zip \
    php83-tokenizer \
    php83-json \
    php83-pecl-redis \
    curl \
    wget \
    unzip \
    bash

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
