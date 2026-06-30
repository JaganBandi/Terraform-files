# Jenkins Installation on AWS EC2 using Terraform (Amazon Linux 2023)

## Project Overview

This project provisions an AWS EC2 instance using Terraform and automatically installs Jenkins on Amazon Linux 2023 using an EC2 User Data script.

After the EC2 instance is created, Jenkins is installed, started, and the Initial Admin Password is displayed in the EC2 System Log.

## Technologies Used

- Terraform
- AWS EC2
- Amazon Linux 2023
- Jenkins
- Java 21 (Amazon Corretto)
- EC2 User Data (Shell Script)

## Project Structure

   text
jenkins-terraform/
│
├── provider.tf
├── ami.tf
├── security-group.tf
├── ec2.tf
├── outputs.tf
├── jenkins.sh
└── README.md


## File Description

### provider.tf

Configures the Terraform version and AWS provider.

### ami.tf

Fetches the latest Amazon Linux 2023 AMI using AWS Systems Manager Parameter Store.

### security-group.tf

Creates a Security Group with the following ports:

- SSH (22)
- HTTP (80)
- Jenkins (8080)

### ec2.tf

Creates the EC2 instance and executes the Jenkins installation script using User Data.

### outputs.tf

Displays:

- Jenkins Public IP
- Jenkins URL

### jenkins.sh

- Installs Java 21
- Installs Jenkins
- Starts Jenkins
- Prints the Initial Admin Password

## Architecture

  text
Terraform
    │
    ▼
AWS Provider
    │
    ▼
Create Security Group
    │
    ▼
Launch EC2 Instance
    │
    ▼
Execute User Data Script
    │
    ▼
Install Java
    │
    ▼
Install Jenkins
    │
    ▼
Start Jenkins
    │
    ▼
Generate Initial Admin Password
    │
    ▼
Print Password to EC2 System Log


## Prerequisites

- AWS Account
- IAM User with EC2 permissions
- AWS CLI Configured
- Terraform Installed
- Existing AWS Key Pair

## Deployment Steps

Initialize Terraform

  bash
terraform init


Validate Configuration

  bash
terraform validate
 

Preview Infrastructure

  bash
terraform plan
 

Create Infrastructure

 bash
terraform apply


Type:

 text
yes


when prompted.

## Access Jenkins

Open your browser:

 text
http://<PUBLIC-IP>:8080


Example:

 text
http://13.xxx.xxx.xxx:8080


## Get Jenkins Initial Admin Password

1. Open AWS Console.
2. Go to EC2.
3. Select the Jenkins Instance.
4. Click **Actions**.
5. Select **Monitor and troubleshoot**.
6. Click **Get system log**.
7. Search for:

  text
Jenkins Initial Admin Password


Copy the password and paste it into the Jenkins Unlock page.

## Destroy Infrastructure

  bash
terraform destroy


## Features

- Infrastructure as Code using Terraform
- Automatic Jenkins Installation
- Latest Amazon Linux 2023 AMI
- Automatic Java Installation
- Automatic Jenkins Startup
- Security Group Configuration
- Jenkins URL Output
- Initial Admin Password available in EC2 System Log
- Modular Terraform Project Structure

## Learning Objectives

- Terraform Basics
- AWS Provider
- EC2 Instance Creation
- Security Groups
- EC2 User Data
- Jenkins Installation
- Infrastructure Automation
- DevOps Best Practices

## Author

**Jagan Kalyan**

