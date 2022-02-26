#!/bin/bash

#ansible-playbook -i hosts 00-common.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 01-nfs.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
