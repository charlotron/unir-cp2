#!/bin/bash

ansible-playbook -i hosts 00-common.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 01-certs-and-fingerprints.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 10-nfs-dir-share.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 20-install-k8s.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 21-configure-k8s-master.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 22-configure-k8s-workers.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts 30-deploy-k8s-pods.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
