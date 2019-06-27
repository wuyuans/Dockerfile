#!/bin/bash

if [ "${HADOOP_TYPE}" == "master" ]; then
    if [ "`ls -A /hadoop_data/hdfs/namenode`" == "" ]; then
      echo "Formatting namenode name directory: /hadoop_data/hdfs/namenode"
      hdfs --config "/hadoop/etc/hadoop" namenode -format -nonInteractive
    fi
    hdfs --config "/hadoop/etc/hadoop" namenode
else
  while [ "$response" != "200" ]
  do
    response=`curl -s -o /dev/null -w "%{http_code}" http://${HADOOP_MASTER_HOST}:50070`
    echo "Hadoop master is not started..."
    sleep 1
  done
  hdfs --config "/hadoop/etc/hadoop" datanode
fi