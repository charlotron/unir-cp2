#!/bin/bash

#Import and execute readEnvs function
. ../ssh_scripts/read-env-vars.sh && readEnvs

#Execute function with environment vars set
terraform destroy -auto-approve
