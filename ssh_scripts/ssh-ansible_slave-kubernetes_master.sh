#!/bin/bash

#Import and execute readEnvs function
. ./read-env-vars.sh && readEnvs

echo "Connecting to host via ssh: $kubernetesmaster"
ssh ansible@$kubernetesmaster -o "StrictHostKeyChecking=no"