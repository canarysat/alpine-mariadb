FROM alpine:latest

ARG BUILD_DATE
ARG VCS_REF

LABEL maintainer="Peter CanarySAT <peter@canarysat.com>" \
    architecture="amd64/x86_64" \
    mariadb-version="10.4.13" \
    alpine-version="latest" \
    build="31-May-2020" \
    org.opencontainers.image.title="alpine-mariadb" \
    org.opencontainers.image.description="MariaDB Docker image running on Alpine Linux" \
    org.opencontainers.image.authors="Peter Pezzano <peter@canarysat.com>" \
    org.opencontainers.image.vendor="CanarySAT" \
    org.opencontainers.image.version="v10.4.13" \
    org.opencontainers.image.url="https://hub.docker.com/canarysat/alpine-mariadb/" \
    org.opencontainers.image.source="https://github.com/canarysat/alpine-mariadb" \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.created=$BUILD_DATE

ENV LANG="en_US.UTF-8" \
    LC_ALL="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"

RUN apk add --no-cache mariadb mariadb-client mariadb-server-utils pwgen && \
    rm -f /var/cache/apk/*

ADD files/run.sh /scripts/run.sh
RUN mkdir /docker-entrypoint-initdb.d && \
    mkdir /scripts/pre-exec.d && \
    mkdir /scripts/pre-init.d && \
    chmod -R 755 /scripts

EXPOSE 3306

VOLUME ["/var/lib/mysql"]

ENTRYPOINT ["/scripts/run.sh"]
