FROM anapsix/alpine-java:8_jdk
MAINTAINER wuyuans

ARG HADOOP_VERSION=2.8.5

VOLUME /data/namenode
VOLUME /data/namenode

ENV HADOOP_HOME /hadoop
ENV HADOOP_MASTER_HOST localhost
ENV HADOOP_TYPE master
ENV PATH ${HADOOP_HOME}/bin:${PATH}

RUN set -euxo pipefail && \
  apk --no-cache add bash curl openssh-client wget openssl && \
  curl http://archive.apache.org/dist/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-$HADOOP_VERSION.tar.gz | tar xvz && \
  mv hadoop-${HADOOP_VERSION} ${HADOOP_HOME} && \
  rm -rf ${HADOOP_HOME}/share/doc

RUN mkdir -p /data/namenode /data/namenode

ADD entrypoint.sh /entrypoint.sh
RUN chmod a+x /entrypoint.sh

COPY conf/core-site.xml ${HADOOP_HOME}/etc/hadoop/
COPY conf/hdfs-site.xml ${HADOOP_HOME}/etc/hadoop/
COPY conf/yarn-site.xml ${HADOOP_HOME}/etc/hadoop/
COPY conf/mapred-site.xml ${HADOOP_HOME}/etc/hadoop/

# Hdfs ports
EXPOSE 50010 50020 50070 50075 50090 8020 9000

# Mapred ports
EXPOSE 10020 19888

# Yarn ports
EXPOSE 8030 8031 8032 8033 8040 8042 8088

CMD "/entrypoint.sh"