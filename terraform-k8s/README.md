# Kubernetes Cluster Setup Using Terraform and AWS

## 1. Project Overview

This project demonstrates how to create a Kubernetes cluster on AWS EC2 instances using Terraform.

Terraform automates the infrastructure creation, while kubeadm is used to set up the Kubernetes cluster. The cluster contains one control-plane node and two worker nodes.

## 2. Project Architecture

- **AWS:** Cloud platform
- **Terraform:** Creates AWS infrastructure
- **EC2:** Runs the Kubernetes nodes
- **Rocky Linux:** Operating system
- **containerd:** Container runtime
- **kubeadm:** Initializes and joins the cluster
- **Kubernetes:** Manages containerized applications
- **Calico:** Provides pod networking

## 3. Cluster Configuration

 Node          Private IP             Role 

 Controller    10.30.1.10        Control Plane 
 Worker 1      10.30.1.11        Worker Node 
 Worker 2      10.30.1.12        Worker Node 

## 4. Project Structure


kubeadm-terraform/
├── main.tf
├── variable.tf
├── terraform.tfvars
├── README.md
└── scripts/
    ├── controller.sh
    └── worker.sh


- main.tf – Defines AWS resources such as the VPC, subnet, security group, and EC2 instances.
- variable.tf – Defines the Terraform input variables.
- terraform.tfvars – Provides values for the variables.
- controller.sh – Automates the control-plane setup.
- worker.sh – Automates the worker-node setup.
- README.md – Documents the project.

## 5. Tools and Technologies

- AWS EC2
- Terraform
- Rocky Linux
- Kubernetes
- kubeadm
- containerd
- Calico
- Linux Shell Scripting
- Git and GitHub

## 6. How to Deploy the Infrastructure

Run these commands from the Terraform project directory.

### Step : Initialize Terraform

terraform init

## Step : Formate the files into a standared, readable style

terraform fmt

Downloads the required Terraform providers.

### Step : Validate the Configuration

terraform validate

Checks the Terraform configuration for errors.

### Step : Review the Execution Plan


terraform plan

Shows the infrastructure changes Terraform intends to make.

### Step : Apply the Configuration

terraform apply

## Step : Display the output values

terraform output


Creates or updates the infrastructure according to the plan. Review the changes before confirming.

**Note:** If the cluster is already running, do not apply changes blindly. Review the plan first to avoid replacing existing instances.

## 7. Verify the Kubernetes Cluster

Connect to the controller node and run:


sudo -i

export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get nodes -o wide

Check the system pods:

kubectl get pods -A


All three nodes should show Ready when the cluster is healthy.

## 8. Deploy a Sample Application

Create an Nginx deployment:

kubectl create deployment nginx --image=nginx




## 9. Learning Outcomes

Through this project, I gained practical experience in:

- Creating AWS infrastructure using Terraform.
- Configuring EC2 instances and networking.
- Automating Linux configuration with shell scripts.
- Installing and configuring containerd.
- Initializing a Kubernetes cluster using kubeadm.
- Joining worker nodes to the control plane.
- Configuring pod networking with Calico.
- Deploying and managing applications using kubectl.
- Troubleshooting basic infrastructure and Kubernetes issues.

## 10. Conclusion

This project helped me understand how infrastructure automation and Kubernetes work together. It provided hands-on practice with AWS, Terraform, Linux, container runtimes, and Kubernetes cluster administration.
