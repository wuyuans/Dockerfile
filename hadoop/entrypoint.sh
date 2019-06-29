#!/bin/bash

function wait_for_it()
{
    local serviceport=$1
    local service=${serviceport%%:*}
    local port=${serviceport#*:}
    local retry_seconds=5
    local max_try=100
    let i=1

    nc -z $service $port
    result=$?

    until [ $result -eq 0 ]; do
      echo "[$i/$max_try] check for ${service}:${port}..."
      echo "[$i/$max_try] ${service}:${port} is not available yet"
      if (( $i == $max_try )); then
        echo "[$i/$max_try] ${service}:${port} is still not available; giving up after ${max_try} tries. :/"
        exit 1
      fi

      echo "[$i/$max_try] try in ${retry_seconds}s once again ..."
      let "i++"
      sleep $retry_seconds

      nc -z $service $port
      result=$?
    done
    echo "[$i/$max_try] $service:${port} is available."
}

#for i in ${SERVICE_PRECONDITION[@]}
#do
#    wait_for_it ${i}
#done

if [ "${HADOOP_TYPE}" == "namenode" ]; then
    if [ "`ls -A /data/namenode`" == "" ]; then
      echo "Formatting namenode name directory: /data/namenode"
      hdfs --config "/hadoop/etc/hadoop" namenode -format -nonInteractive
    fi
    hdfs --config "/hadoop/etc/hadoop" namenode
elif [ "${HADOOP_TYPE}" == "datanode" ]; then
  hdfs --config "/hadoop/etc/hadoop" datanode
elif [ "${HADOOP_TYPE}" == "historyserver" ]; then
  yarn --config "/hadoop/etc/hadoop" historyserver
elif [ "${HADOOP_TYPE}" == "nodemanager" ]; then
  yarn --config "/hadoop/etc/hadoop" nodemanager
elif [ "${HADOOP_TYPE}" == "resourcemanager" ]; then
  yarn --config "/hadoop/etc/hadoop" resourcemanager
else
  echo "Sorry, $HADOOP_TYPE not recognized."
  exit 1
fi