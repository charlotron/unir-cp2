#!/bin/bash

#Import and execute readEnvs function
. ./read-env-vars.sh && readEnvs

echo "Connecting to host via ssh: $kubernetesworker2"
ssh ansible@$kubernetesworker2 -o "StrictHostKeyChecking=no"
