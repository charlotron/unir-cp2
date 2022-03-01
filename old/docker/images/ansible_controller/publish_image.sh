#!/bin/sh

#Build the docker stack
docker build -t charlotron/ansible-controller .

#Push docker images to docker hub
docker push charlotron/ansible-controller