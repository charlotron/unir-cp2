#!/bin/sh

#Build the docker stack
docker build -t charlotron/ansible-slave .

#Push docker images to docker hub
docker push charlotron/ansible-slave