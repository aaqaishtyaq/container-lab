#!/bin/bash

apt-get update -y
apt-get upgrade -y
apt-get -y install \
		apt-transport-https \
		ca-certificates \
		curl \
		gnupg-agent \
		software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install docker-ce docker-ce-cli containerd.io -y

# Required for rootless docker
apt-get install dbus-user-session docker-ce-rootless-extras -y
usermod -aG docker ubuntu

# Install docker-compose
curl -L https://github.com/docker/compose/releases/download/v2.6.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Cleanup
apt-get -y autoremove --purge
apt-get clean
