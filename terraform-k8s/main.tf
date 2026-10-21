
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "kubeadm" {
  cidr_block           = "10.30.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "kubeadm-lab-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.kubeadm.id
  cidr_block              = "10.30.1.0/24"
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "kubeadm-lab-public-subnet"
  }
}

resource "aws_internet_gateway" "kubeadm" {
  vpc_id = aws_vpc.kubeadm.id

  tags = {
    Name = "kubeadm-lab-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.kubeadm.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.kubeadm.id
  }

  tags = {
    Name = "kubeadm-lab-public-rt"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}


resource "aws_security_group" "kubeadm" {
  name        = "kubeadm-lab-sg"
  description = "Security group for the kubeadm Kubernetes lab"
  vpc_id      = aws_vpc.kubeadm.id

  ingress {
    description = "SSH from the jump server"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "Kubernetes API access from the jump server"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = [var.admin_cidr]
  }

  ingress {
    description = "Internal communication between Kubernetes nodes"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    self        = true
  }

  egress {
    description = "Outbound traffic for package downloads and cluster operation"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "kubeadm-lab-sg"
  }
}
