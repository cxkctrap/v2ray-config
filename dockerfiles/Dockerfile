FROM node:alpine3.10

WORKDIR /root
COPY ./ /etc/v2ray-config
RUN set -ex \
    && chmod +x /etc/v2ray-config/v2ray-config.sh \
    && mkdir /etc/caddy \
    && apk upgrade --update \
    && apk add --no-cache bash git curl \
    # && apt-get install -y --no-install-recommends git curl \
    # && apt-get install -y nodejs npm \
    && git clone https://github.com/233boy/v2ray -b "master" /etc/v2ray/233boy/v2ray --depth=1 \
    && git clone https://github.com/pengchujin/v2rayDocker -b "master" /etc/v2rayDocker --depth=1 \
    && cd /etc/v2rayDocker \
    && npm install \
    && apk del git \
    && rm -rf /tmp/v2ray /var/cache/apk/*
    # && apt-get remove git -y --purge \
    # && apt-get clean -y \
    # && rm -rf /var/lib/apt/lists/* \
    # && apt-get autoremove -y

ENTRYPOINT [ "/etc/v2ray-config/v2ray-config.sh" ]