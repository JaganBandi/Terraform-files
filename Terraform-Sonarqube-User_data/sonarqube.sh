#!/bin/bash

# Update packages
dnf update -y

# Install Docker
dnf install docker -y

# Enable and start Docker
systemctl enable docker
systemctl start docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Pull SonarQube image
docker pull sonarqube:lts-community

# Run SonarQube container
docker run -d --name sonarqube --restart unless-stopped -p 9000:9000 sonarqube:lts-community