#!/bin/bash

#Import and execute readEnvs function
. ./read-env-vars.sh && readEnvs

echo "Connecting to host via ssh: $ansiblecontroller"
ssh ansible@$ansiblecontroller -o "StrictHostKeyChecking=no"