# Prerequisites

- install latest Docker Toolbox https://www.docker.com/products/docker-toolbox
- create dedicated docker machine for oneops
~~~ bash
docker-machine create -d virtualbox --virtualbox-memory "8196" oneops-docker-machine
~~~
- setup your shell and verify your docker machine
~~~ bash
eval $(docker-machine env oneops-docker-machine)
docker info
~~~

To create a docker machine with a different driver see https://docs.docker.com/machine/drivers/


# Installation

- clone the oneops setup repo
~~~ bash
git clone https://github.com/oneops/setup
cd setup/docker
export COMPOSE_PROJECT_NAME=oneops
~~~

- build oneops container images ~ 10 min (re-run this command anytime there are changes in the setup repo)
~~~ bash
docker-compose build
~~~
- build oneops code ~ 15 min (re-run this command anytime you want to update your instance with latest oneops code)
~~~ bash
docker-compose run --rm jenkins build
~~~
- start oneops container images (oneops code is re-deployed on startup)
~~~ bash
docker-compose up -d
~~~
- verify all containers started
~~~ bash
docker-compose ps
   Name                   Command               State                       Ports
-------------------------------------------------------------------------------------------------------
activemq        /usr/bin/supervisord -n -c ...   Up      61616/tcp, 0.0.0.0:61617->61617/tcp, 8161/tcp
cassandra       /usr/bin/supervisord -n -c ...   Up      0.0.0.0:7000->7000/tcp, 0.0.0.0:9160->9160/tcp
elasticsearch   /usr/bin/supervisord -n -c ...   Up      0.0.0.0:9200->9200/tcp, 0.0.0.0:9300->9300/tcp
inductor        /usr/bin/supervisord -n -c ...   Up
jenkins         /usr/bin/supervisord -n -c ...   Up      0.0.0.0:3001->3001/tcp
logstash        /usr/bin/supervisord -n -c ...   Up      0.0.0.0:32768->5000/tcp
postgres        /usr/bin/supervisord -n -c ...   Up      0.0.0.0:5432->5432/tcp
rails           /usr/bin/supervisord -n -c ...   Up      0.0.0.0:3000->3000/tcp
tomcat          /usr/bin/supervisord -n -c ...   Up      0.0.0.0:8080->8080/tcp
~~~

To access your new oneops instance go to `http://<ip>:3000` where _ip_ is the ip address of your docker machine which you can retrieve with  `docker-machine ip oneops-docker-machine`

To create local _oneops/centos7_ base image instead of using the public one from the docker hub run `docker built --rm -t oneops/centos7 .`

# Troubleshooting

- To see logs from all containers run `docker-compose logs`
- To view deployment logs via inductor logs run `docker-compose logs inductor`
- To access any container use `docker exec -it <container> bash` where _container_ is the name of one of the oneops containers listed in `docker-compose ps`
