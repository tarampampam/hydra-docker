FROM debian:jessie

LABEL \
    org.label-schema.name="hydra" \
    org.label-schema.description="Docker image with hydra" \
    org.label-schema.url="https://github.com/tarampampam/hydra-docker" \
    org.label-schema.vcs-url="https://github.com/tarampampam/hydra-docker" \
    org.label-schema.vendor="Tarampampam" \
    org.label-schema.license="WTFPL" \
    org.label-schema.schema-version="1.0"

ARG HYDRA_VER="9.1"
ENV HYDRA_VER="${HYDRA_VER}"

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
