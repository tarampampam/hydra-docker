FROM debian:buster-slim

ARG HYDRA_VER="9.1"

LABEL \
  maintainer="tarampampam" \
  org.opencontainers.image.url="https://github.com/tarampampam/hydra-docker" \
  org.opencontainers.image.source="https://github.com/tarampampam/hydra-docker" \
  org.opencontainers.image.version=$HYDRA_VER \
  org.opencontainers.image.vendor="tarampampam" \
  org.opencontainers.image.title="hydra" \
  org.opencontainers.image.description="Docker image with hydra" \
  org.opencontainers.image.licenses="WTFPL"

RUN set -x \
    && apt-get update \
    && apt-get -y install \
        libmysqlclient-dev \
        libgpg-error-dev \
        #libmemcached-dev \
        libgcrypt11-dev \
        libgcrypt20-dev \
        ca-certificates \
        #libgtk2.0-dev \
        libpcre3-dev \
        #firebird-dev \
        libidn11-dev \
        libssh-dev \
        #libsvn-dev \
        libssl-dev \
        #libpq-dev \
        make \
        curl \
        gcc \
    && rm -rf /var/lib/apt/lists/* \

    # Get hydra sources and compile
    && curl -SsL "https://github.com/vanhauser-thc/thc-hydra/archive/v${HYDRA_VER}.tar.gz" -o /tmp/src.tar.gz \
    && tar xvzf /tmp/src.tar.gz -C /tmp \
    && cd "/tmp/thc-hydra-${HYDRA_VER}" \
    && ./configure \
    && make \
    && make install \
    && rm -Rf "/tmp/thc-hydra-${HYDRA_VER}" /tmp/src.tar.gz \
    && apt-get purge -y make gcc \
    && apt-get autoremove -y \
    && apt-get autoclean -y \

    # Get password lists, login lists and etc
    && curl -SL https://github.com/danielmiessler/SecLists/archive/master.tar.gz -o /tmp/seclists.tar.gz \
    && tar xvzf /tmp/seclists.tar.gz -C /tmp \
    && mv /tmp/SecLists-master/Passwords /opt/passwords \
    && mv /tmp/SecLists-master/Usernames /opt/usernames \
    && rm -Rf /tmp/SecLists-master /tmp/seclists.tar.gz

ENTRYPOINT ["/usr/local/bin/hydra"]
