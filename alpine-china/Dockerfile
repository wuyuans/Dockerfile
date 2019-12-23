FROM alpine:3.10.3
MAINTAINER wuyuans

RUN set -euxo pipefail && apk add --no-cache ca-certificates tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone