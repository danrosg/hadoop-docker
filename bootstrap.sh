#!/bin/bash

: ${HADOOP_HOME:=/opt/hadoop}


service ssh start
$HADOOP_HOME/sbin/start-dfs.sh


if [[ $1 == "-d" ]]; then
  while true; do sleep 1000; done
fi

if [[ $1 == "-bash" ]]; then
  /bin/bash
fi
