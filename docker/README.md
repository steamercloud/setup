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
~~~

To access your new oneops instance go to `http://<ip>:9090` where <ip> is the ip address of your docker machine which you can retrieve with  `docker-machine ip oneops-docker-machine`


# Troubleshooting

To access a container use `docker exec -it <container> bash` where <container> is the name of one of the oneops containers listed in `docker-compose ps`
