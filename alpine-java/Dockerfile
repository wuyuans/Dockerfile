FROM alpine:latest
MAINTAINER wuyuans

RUN set -euxo pipefail && apk add --no-cache openjdk8 ca-certificates

ENV JAVA_HOME /usr/lib/jvm/default-jvm
ENV PATH ${JAVA_HOME}/bin:${PATH}

CMD /bin/sh