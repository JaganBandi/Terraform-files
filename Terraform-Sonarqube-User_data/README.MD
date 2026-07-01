# SonarQube Deployment using Terraform

## Project Description

This project deploys SonarQube Community Edition on an AWS EC2 instance using Terraform and Docker.

Terraform creates the EC2 instance and Security Group. During instance creation, a shell script installs Docker, pulls the SonarQube Docker image, and starts the SonarQube container automatically.


## Project Files

─ main.tf
─ install-sonarqube.sh
─ README.md




## Prerequisites

- AWS Account
- AWS CLI configured
- Terraform installed
- AWS EC2 Key Pair



## Steps to Deploy

### Initialize Terraform

  bash
terraform init


### Check the Execution Plan

  bash
terraform plan


### Create the Infrastructure

  bash
terraform apply --auto-approve


## Access SonarQube

After the EC2 instance is created, wait a few minutes for the Docker container to start.

Open your browser:


http://3.110.45.39:9000


Default Login:

Username: admin
Password: admin

## Destroy Resources

To delete all AWS resources:

  bash
terraform destroy


## Author

**Jagan Kalyan**