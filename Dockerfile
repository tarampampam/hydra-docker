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
        #libmysqlclient-dev \
        default-libmysqlclient-dev \
        libgpg-error-dev \
        #libmemcached-dev \
        #libgcrypt11-dev \
        libgcrypt-dev \
        #libgcrypt20-dev \
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
        1>/dev/null \
    # Get hydra sources and compile
    && ( mkdir /tmp/hydra \
        && curl -SsL "https://github.com/vanhauser-thc/thc-hydra/archive/v${HYDRA_VER}.tar.gz" -o /tmp/hydra/src.tar.gz \
        && tar xzf /tmp/hydra/src.tar.gz -C /tmp/hydra \
        && cd "/tmp/hydra/thc-hydra-${HYDRA_VER}" \
        && ./configure 1>/dev/null \
        && make 1>/dev/null \
        && make install \
        && rm -Rf /tmp/hydra ) \
    # Make clean
    && apt-get purge -y make gcc libgpg-error-dev libgcrypt-dev \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    # Verify hydra installation
    && hydra -h || error_code=$? \
    && if [ ! "${error_code}" -eq 255 ]; then echo "Wrong exit code for 'hydra help' command"; exit 1; fi \
    # Unprivileged user creation
    && adduser \
        --disabled-password \
        --gecos "" \
        --home /tmp \
        --shell /sbin/nologin \
        --no-create-home \
        --uid 10001 \
        hydra

ARG SECLIST_VER="2020.3"

RUN set -x \
    # If build argument `SECLIST_VER` is empty (`docker build --build-arg "SECLIST_VER=" ...`) - skip seclist getting
    && if [ "_${SECLIST_VER}" != "_" ]; then \
        # Get password & login lists (very large archive, about 970 MiB summary)
        ( mkdir /tmp/seclists \
            && curl -SsL "https://github.com/danielmiessler/SecLists/archive/${SECLIST_VER}.tar.gz" -o /tmp/seclists/src.tar.gz \
            && tar xzf /tmp/seclists/src.tar.gz -C /tmp/seclists \
            && mv "/tmp/seclists/SecLists-${SECLIST_VER}/Passwords" /opt/passwords \
            && mv "/tmp/seclists/SecLists-${SECLIST_VER}/Usernames" /opt/usernames \
            && chmod -R u+r /opt/passwords /opt/usernames \
            && rm -Rf /tmp/seclists ) \
    fi;

# Use an unprivileged user
USER hydra:hydra

ENTRYPOINT ["/usr/local/bin/hydra"]
