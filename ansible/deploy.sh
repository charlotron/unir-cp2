#!/bin/bash

ansible-playbook -i hosts tasks/00-common.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/10-nfs-dir-share.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/20-install-k8s.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/21-configure-k8s-master.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/22-configure-k8s-workers.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/30-deploy-k8s-pods.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
ansible-playbook -i hosts tasks/40-deploy-load-balancer.yml -v --ssh-common-args='-o StrictHostKeyChecking=no'
