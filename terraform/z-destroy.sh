#!/bin/bash

#Import and execute readEnvs function
. ./z-read-env-vars.sh && readEnvs

#Execute function with environment vars set
terraform destroy
