FROM alpine:3.20

# FIX: install ca-certificates BEFORE apk update to fix SSL issue
RUN apk update && add --no-cache  ca-certificates

# Now update + install tools
RUN apk update && apk add --no-cache

#RUN mkdir -p /var/www/wordpress

# # Download and unpack WordPress
# WORKDIR /var/www/wordpress
# RUN curl -O https://wordpress.org/latest.tar.gz && \
#     tar -xzf latest.tar.gz --strip-components=1 && \
#     rm latest.tar.gz

# # Copy custom entrypoint (we’ll write this next)
# COPY tools/setup.sh /setup.sh
# RUN chmod +x /setup.sh

# # Set working directory
# WORKDIR /var/www/wordpress

# EXPOSE 9000

# CMD ["/setup.sh"]
