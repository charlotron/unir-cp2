#!/bin/bash

#Import and execute readEnvs function
. ./read-env-vars.sh && readEnvs

echo "Connecting to host via ssh: $kubernetesworker1"
ssh ansible@$kubernetesworker1 -o "StrictHostKeyChecking=no"