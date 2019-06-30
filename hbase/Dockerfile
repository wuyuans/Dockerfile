FROM anapsix/alpine-java:8_jdk
MAINTAINER wuyuans

ARG HBASE_VERSION=2.0.5

VOLUME /data/hbase

ENV HBASE_HOME /hbase
ENV HBASE_TYPE master
ENV PATH ${HBASE_HOME}/bin:${PATH}

RUN set -euxo pipefail && \
  apk --no-cache add bash curl openssh-client wget openssl && \
  curl http://archive.apache.org/dist/hbase/${HBASE_VERSION}/hbase-${HBASE_VERSION}-bin.tar.gz | tar xvz && \
  mv hbase-${HBASE_VERSION} ${HBASE_HOME} && \
  rm -rf ${HBASE_HOME}/docs

RUN mkdir -p /data/hbase

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

COPY conf/hbase-site.xml ${HBASE_HOME}/conf/

# master ports
EXPOSE 16000 16010

# regionserver ports
EXPOSE 16020 16030

CMD "/entrypoint.sh"