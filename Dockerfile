FROM bcgdesign/nginx:1.18.0-r1

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx Proxy" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

# port 80 is already exposed by the base image
EXPOSE 443

ENV LETS_ENCRYPT_EMAIL= \
    LETS_ENCRYPT_LIVE=0 \
    SSL_CLEAN_INSTALL=0

RUN apk -U upgrade \
    && apk add \
        bash \
        curl \
        gomplate \
        openssl \
    && rm -rf /var/cache/apk/* /etc/nginx/sites /www/* /tmp/*

COPY ./overlay /

RUN ln -s /ssl/certs /etc/ssl/certs
RUN ln -s /sites /etc/nginx/sites
VOLUME [ "/ssl", "/sites" ]
