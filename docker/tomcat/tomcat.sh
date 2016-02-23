#!/bin/bash

export CMS_DES_PEM=/home/oneops/certs/oo.key
export IS_SEARCH_ENABLED=true
export KLOOPZ_NOTIFY_PASS=notifypass
export KLOOPZ_AMQ_PASS=amqpass
export CMS_DB_HOST=kloopzcmsdb
export CMS_DB_USER=kloopzcm
export CMS_DB_PASS=kloopzcm
export ACTIVITI_DB_HOST=activitidb
export ACTIVITI_DB_USER=activiti
export ACTIVITI_DB_PASS=activiti
export CMS_API_HOST=localhost
export CONTROLLER_WO_LIMIT=500
export AMQ_USER=superuser
export ECV_USER=oneops-ecv
export ECV_SECRET=ecvsecret
export API_USER=oneops-api
export API_SECRET=apisecret
export API_ACESS_CONTROL=permitAll
export NOTIFICATION_SYSTEM_USER=admin
export JAVA_OPTS="-Doneops.url=http://localhost:3000 -Dcom.oneops.controller.use-shared-queue=true"
export CATALINA_PID=/var/run/tomcat7.pid

now=$(date +"%T")

echo "Deploying tomcat web apps: $now "

mkdir -p /home/oneops/certs

if [ ! -e /home/oneops/certs/oo.key ]; then
cd /home/oneops/certs
dd if=/dev/urandom count=24 bs=1 | xxd -ps > oo.key
truncate -s -1 oo.key
chmod 400 oo.key
chown tomcat7:root oo.key
fi

cd /usr/local/tomcat7/webapps/

rm -rf *

cp $OO_HOME/dist/oneops/dist/*.war /usr/local/tomcat7/webapps

mkdir -p /opt/oneops/controller/antenna/retry
mkdir -p /opt/oneops/opamp/antenna/retry
mkdir -p /opt/oneops/cms-publisher/antenna/retry

/usr/local/tomcat7/bin/catalina.sh run

now=$(date +"%T")
echo "Done with Tomcat: $now "
