#!/bin/bash

dnf update -y

dnf install -y java-21-amazon-corretto wget

wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins

systemctl enable jenkins
systemctl start jenkins

echo "===================================="
echo "Waiting for Jenkins..."
echo "===================================="

while [ ! -f /var/lib/jenkins/secrets/initialAdminPassword ]
do
    sleep 5
done

PASSWORD=$(cat /var/lib/jenkins/secrets/initialAdminPassword)

echo "===================================="
echo "Jenkins Initial Admin Password"
echo "$PASSWORD"
echo "===================================="

echo "$PASSWORD" > /home/ec2-user/jenkins-password.txt

chown ec2-user:ec2-user /home/ec2-user/jenkins-password.txt