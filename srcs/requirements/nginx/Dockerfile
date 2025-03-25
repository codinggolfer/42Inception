FROM alpine:3.20

RUN sed -i 's/https/http/' /etc/apk/repositories

RUN apk update && apk add --no-cache nginx openssl

# Create directories for SSL certs and NGINX config
RUN mkdir -p /etc/nginx/ssl /run/nginx

# Copy nginx config and certs
COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY tools/ssl/ /etc/nginx/ssl/

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]