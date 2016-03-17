#!/bin/bash

PATH=/sbin:/usr/sbin:/bin:/usr/bin
export PATH

if [ `id -u` -ne 0 ]; then
   echo "You need root privileges to run this script"
   exit 1
fi

name=logstash
pidfile="/var/run/$name.pid"

LS_USER=logstash
LS_GROUP=logstash
LS_HOME=/var/lib/logstash
LS_HEAP_SIZE="500m"
LS_LOG_DIR=/var/log/logstash
LS_LOG_FILE="${LS_LOG_DIR}/$name.log"
LS_CONF_DIR=/etc/logstash/conf.d
LS_OPEN_FILES=16384
LS_NICE=19
LS_OPTS=""


[ -r /etc/default/$name ] && . /etc/default/$name
[ -r /etc/sysconfig/$name ] && . /etc/sysconfig/$name

program=/opt/logstash/bin/logstash
args="agent -f ${LS_CONF_DIR} -l ${LS_LOG_FILE} ${LS_OPTS}"

LS_JAVA_OPTS="${LS_JAVA_OPTS} -Djava.io.tmpdir=${LS_HOME}"
HOME=${LS_HOME}
export PATH HOME LS_HEAP_SIZE LS_JAVA_OPTS LS_USE_GC_LOGGING

# chown doesn't grab the suplimental groups when setting the user:group - so we have to do it for it.
# Boy, I hope we're root here.
SGROUPS=$(id -Gn "$LS_USER" | tr " " "," | sed 's/,$//'; echo '')

if [ ! -z $SGROUPS ]
then
  EXTRA_GROUPS="--groups $SGROUPS"
fi

# set ulimit as (root, presumably) first, before we drop privileges
ulimit -n ${LS_OPEN_FILES}

 # Run the program!
exec \"$program\" $args
