terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group
resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-security-group"
  description = "Allow SSH and SonarQube"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SonarQube-SG"
  }
}

# EC2 Instance
resource "aws_instance" "sonarqube_server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "t3.medium"
  key_name                    = "YOUR-KEYPAIR-NAME"
  vpc_security_group_ids      = [aws_security_group.sonarqube_sg.id]
  associate_public_ip_address = true

  user_data = file("install-sonarqube.sh")

  tags = {
    Name = "SonarQube-Server"
  }
}

# Output Public IP
output "public_ip" {
  description = "Public IP of SonarQube Server"
  value       = aws_instance.sonarqube_server.public_ip
}terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

# Get the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["137112412989"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Security Group
resource "aws_security_group" "sonarqube_sg" {
  name        = "sonarqube-security-group"
  description = "Allow SSH and SonarQube"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SonarQube-SG"
  }
}

# EC2 Instance
resource "aws_instance" "sonarqube_server" {
  ami                         = data.aws_ami.amazon_linux_2023.id
  instance_type               = "c7i-flex.large"
  key_name                    = "sonar"
  vpc_security_group_ids      = [aws_security_group.sonarqube_sg.id]
  associate_public_ip_address = true

  user_data = file("./sonarqube.sh")

  tags = {
    Name = "SonarQube-Server"
  }
}

# Output Public IP
output "public_ip" {
  description = "Public IP of SonarQube Server"
  value       = aws_instance.sonarqube_server.public_ip
}