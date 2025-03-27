FROM alpine:3.20

RUN sed -i 's/https/http/' /etc/apk/repositories

RUN apk update && apk add --no-cache nginx openssl

# Create directories for SSL certs and NGINX config
RUN mkdir -p /etc/nginx/ssl /run/nginx


# RUN		chown -R www-data:www-data /etc/nginx

VOLUME	/var/www/html
WORKDIR	/var/www/html
# Copy nginx config and certs
COPY conf/default.conf /etc/nginx/http.d/default.conf

RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/nginx/ssl/key.pem \
-out /etc/nginx/ssl/cert.pem \
-subj "/C=FI/ST=Uusimaa/L=Helsinki/CN=$DOMAIN_NAME"

RUN chmod 600 /etc/nginx/ssl/key.pem
RUN chmod 600 /etc/nginx/ssl/cert.pem

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]