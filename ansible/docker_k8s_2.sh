#!/bin/bash

sudo apt-get update && sudo apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
sudo cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl

# add to: nano /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
# Environment=”cgroup-driver=systemd/cgroup-driver=cgroupfs”

kubeadm init --apiserver-advertise-address=10.10.10.100  --pod-network-cidr=10.10.10.0/24 --ignore-preflight-errors=all