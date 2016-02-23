#!/bin/bash

export OO_HOME=/home/oneops

ES_USER="elasticsearch"
ES_GROUP="elasticsearch"
ES_HOME="/usr/share/elasticsearch"
MAX_OPEN_FILES=65535
MAX_MAP_COUNT=262144
LOG_DIR="/var/log/elasticsearch"
DATA_DIR="/var/lib/elasticsearch"
WORK_DIR="/tmp/elasticsearch"
CONF_DIR="/etc/elasticsearch"
CONF_FILE="/etc/elasticsearch/elasticsearch.yml"
PID_DIR="/var/run/elasticsearch"

# Source the default env file
ES_ENV_FILE="/etc/sysconfig/elasticsearch"
if [ -f "$ES_ENV_FILE" ]; then
    . "$ES_ENV_FILE"
fi

exec="$ES_HOME/bin/elasticsearch"
prog="elasticsearch"
pidfile="$PID_DIR/${prog}.pid"

export ES_HEAP_SIZE
export ES_HEAP_NEWSIZE
export ES_DIRECT_SIZE
export ES_JAVA_OPTS
export JAVA_HOME

lockfile=/var/lock/subsys/$prog

$exec -p $pidfile -Des.default.path.home=$ES_HOME -Des.default.path.logs=$LOG_DIR -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR
