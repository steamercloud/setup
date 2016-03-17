#!/bin/sh

export KLOOPZ_AMQ_PASS=amqpass

echo "Deploying amq plugin: $now "

cp $OO_HOME/dist/oneops/dist/amq-config.tar.gz  /opt/activemq/amq-config.tar.gz
cp $OO_HOME/dist/oneops/dist/amqplugin-fat.jar  /opt/activemq/lib/amqplugin-fat.jar

cd /opt/activemq

tar -xzvf amq-config.tar.gz

cd /opt/activemq/conf

if [ -e activemq.orig ]; then
cp activemq.xml activemq.orig
fi

cp amq_local_kahadb.xml activemq.xml

cp /opt/activemq/keys/* .

# needed later for the inductors
cp /opt/activemq/conf/client.ts $OO_HOME/client.ts

/opt/activemq/bin/linux-x86-64/activemq console
