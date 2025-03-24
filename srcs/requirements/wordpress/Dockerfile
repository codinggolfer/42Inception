FROM alpine:3.20


# Step 1: Install SSL certificates first to avoid HTTPS errors
RUN apk update && apk add --no-cache ca-certificates

# Step 2: Now you can update & install everything else
RUN apk update && apk add --no-cache \
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
