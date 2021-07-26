FROM alpine:3.6

LABEL maintainer="esplo <esplo@users.noreply.github.com>"

ENV NGINX_VERSION 1.13.5

RUN apk add --no-cache openssl nginx gettext \
    && mkdir -p /etc/nginx/ssl/ \
    && openssl req -x509 -nodes -days 365 -subj "/C=CA/ST=QC/O=Company, Inc./CN=mydomain.com" -addext "subjectAltName=DNS:mydomain.com" -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx-selfsigned.key -out /etc/nginx/ssl/nginx-selfsigned.crt; \
    && mkdir -p /run/nginx/

COPY nginx.conf.template /etc/nginx/nginx.conf.template
COPY entrypoint.sh .

EXPOSE 443
STOPSIGNAL SIGTERM

ENTRYPOINT sh entrypoint.sh
