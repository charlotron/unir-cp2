#!/bin/bash

ansible-playbook -i hosts 00-common.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 01-certs-and-fingerprints.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 10-sshfs-dir-share.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'