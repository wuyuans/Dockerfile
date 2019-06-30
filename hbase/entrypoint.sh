#!/bin/bash


if [ "${HBASE_TYPE}" == "master" ]; then
    hbase master start
elif [ "${HBASE_TYPE}" == "regionserver" ]; then
  hbase regionserver start
else
  echo "Sorry, $HBASE_TYPE not recognized."
  exit 1
fi