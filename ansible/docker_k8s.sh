#!/bin/bash

# Installing Docker CE
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
sudo apt-get update -y && sudo apt-get install -y docker-ce docker-ce-cli containerd.io
sudo usermod -a -G docker ansible

# Installing Kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.15.0/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Installing Minikube
mkdir tmp -p
cd tmp
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

sudo service docker start

#minikube start      --extra-config=apiserver.service-account-issuer=api      --extra-config=apiserver.service-account-signing-key-file=/var/lib/minikube/certs/apiserver.key      --extra-config=apiserver.service-account-api-audiences=api      --driver=docker