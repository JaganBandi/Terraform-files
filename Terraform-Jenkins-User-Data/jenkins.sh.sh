#!/bin/bash

dnf update -y

dnf install -y java-21-amazon-corretto wget

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins

systemctl enable jenkins
systemctl start jenkins

sleep 30

cat /var/lib/jenkins/secrets/initialAdminPassword > /home/ec2-user/jenkins-password.txt

chown ec2-user:ec2-user /home/ec2-user/jenkins-password.txt