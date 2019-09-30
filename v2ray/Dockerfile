FROM alpine:latest

MAINTAINER wuyuans

ENV V2RAY_VERSION v4.20.0
ENV V2RAY_LOG_DIR /var/log/v2ray
ENV V2RAY_CONFIG_DIR /etc/v2ray/
ENV V2RAY_DOWNLOAD_URL https://github.com/v2ray/v2ray-core/releases/download/${V2RAY_VERSION}/v2ray-linux-64.zip

RUN apk upgrade --update \
    && apk add \
        curl \
        ca-certificates \
    && mkdir -p \
        ${V2RAY_LOG_DIR} \
        ${V2RAY_CONFIG_DIR} \
        /tmp/v2ray \
    && curl -L -H "Cache-Control: no-cache" -o /tmp/v2ray/v2ray.zip ${V2RAY_DOWNLOAD_URL} \
    && unzip /tmp/v2ray/v2ray.zip -d /tmp/v2ray/ \
    && mv /tmp/v2ray/v2ray-${V2RAY_VERSION}-linux-64/v2ray /usr/bin \
    && mv /tmp/v2ray/v2ray-${V2RAY_VERSION}-linux-64/vpoint_vmess_freedom.json /etc/v2ray/config.json \
    && chmod +x /usr/bin/v2ray \
    && apk del curl \
    && rm -rf /tmp/v2ray /var/cache/apk/*

ENTRYPOINT ["v2ray","-config","/etc/v2ray/config.json"]