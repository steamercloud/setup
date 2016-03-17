#!/bin/bash

now=$(date +"%T")
echo "Deploying search: $now "

export OO_HOME=/home/oneops

curl http://localhost:9200
while [ $? != 0 ]; do
        sleep 1
        curl http://localhost:9200
done

curl -d @/var/cms_template.json -X PUT http://localhost:9200/_template/cms_template
curl -d @/var/event_template.json -X PUT http://localhost:9200/_template/event_template

java -jar -Dindex.name=cms-all -Dnodes=localhost:9300 -Damq.pass=amqpass -Dcluster.name=oneops -DKLOOPZ_AMQ_HOST=localhost -Dsearch.maxConsumers=10 $OO_HOME/dist/oneops/dist/search.jar

now=$(date +"%T")
echo "Done with search-consumer: $now "
