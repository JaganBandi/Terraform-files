# Jenkins Installation on AWS EC2 using Terraform (User Data Method)

## Project Overview

This project demonstrates how to provision an AWS EC2 instance using Terraform and automatically install Jenkins on Amazon Linux 2023 using an EC2 User Data shell script.

The User Data script runs automatically when the EC2 instance launches for the first time. It installs Java, configures the Jenkins repository, installs Jenkins, starts the Jenkins service, and displays the Initial Admin Password in the EC2 System Log.

## Technologies Used

- Terraform
- AWS EC2
- Amazon Linux 2023
- Jenkins
- Java 21 (Amazon Corretto)
- Shell Scripting
- EC2 User Data

## Project Structure

  text
Terraform-Jenkins-UserData/
│
├── main.tf
├── jenkins.sh
└── README.md


## Files Description

### main.tf

- Configures the AWS provider
- Retrieves the latest Amazon Linux 2023 AMI
- Creates the Security Group
- Launches the EC2 instance
- Executes the User Data script
- Displays the Jenkins URL and Public IP

### jenkins.sh

Performs the following tasks automatically:

- Updates the operating system
- Installs Java 21
- Adds the Jenkins repository
- Imports the Jenkins GPG key
- Installs Jenkins
- Starts and enables the Jenkins service
- Waits for Jenkins to initialize
- Displays the Initial Admin Password
- Saves the password to a file

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
Start Jenkins Service
      │
      ▼
Generate Initial Admin Password
      │
      ▼
Display Password in EC2 System Log


## Prerequisites

- AWS Account
- IAM User with EC2 permissions
- AWS CLI configured
- Terraform installed
- Existing EC2 Key Pair

## Deployment Steps

### Initialize Terraform

  bash
terraform init


### Validate Configuration

 bash
terraform validate


### Preview Infrastructure

 bash
terraform plan


### Create Infrastructure

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

### Method 1: EC2 System Log (Without SSH)

1. Open the AWS Management Console.
2. Go to **EC2**.
3. Select the Jenkins EC2 instance.
4. Click **Actions**.
5. Select **Monitor and troubleshoot**.
6. Click **Get system log**.
7. Search for:

  text
Jenkins Initial Admin Password


Copy the password and paste it into the Jenkins Unlock page.

### Method 2: SSH into the Instance

  bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword


## Destroy Infrastructure

  bash
terraform destroy


## Features

- Infrastructure as Code (IaC) using Terraform
- Automatic EC2 provisioning
- Automatic Jenkins installation
- Amazon Linux 2023
- Automatic Java installation
- EC2 User Data Bootstrapping
- Security Group creation
- Jenkins URL output
- Initial Admin Password displayed in EC2 System Log

## Learning Outcomes

- Terraform Basics
- AWS Provider
- EC2 Instance Creation
- Security Groups
- EC2 User Data
- Shell Scripting
- Jenkins Installation
- Infrastructure Automation
- DevOps Best Practices

## Author

**Jagan Kalyan**
