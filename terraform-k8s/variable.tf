
variable "aws_region" {
  description = "AWS region for the Kubernetes lab"
  type        = string
  default     = "ap-south-1"
}

variable "admin_cidr" {
  description = "Trusted public IP CIDR allowed to SSH to the cluster"
  type        = string
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
  default     = "terrafrom"
}

variable "controller_instance_type" {
  description = "EC2 instance type for the control plane"
  type        = string
  default     = "m7i-flex.large"
}

variable "worker_instance_type" {
  description = "EC2 instance type for worker nodes"
  type        = string
  default     = "c7i-flex.large"
}
