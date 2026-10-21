#!/bin/bash
set -Eeuo pipefail
exec > >(tee -a /var/log/k8s-bootstrap.log) 2>&1

# Kubernetes worker bootstrap
# Rocky Linux 9
# Controller private IP: 10.30.1.10

if [ "$(id -u)" -ne 0 ]; then
    echo "Run this script as root."
    exit 1
fi

if [ -f /etc/kubernetes/kubelet.conf ]; then
    echo "This worker already has Kubernetes kubelet configuration."
    exit 0
fi

echo "Configuring Kubernetes worker..."

swapoff -a
sed -ri '/^[^#].*\sswap\s/s/^/#/' /etc/fstab

cat > /etc/modules-load.d/k8s.conf <<'EOF'
overlay
br_netfilter
EOF

modprobe overlay
modprobe br_netfilter

cat > /etc/sysctl.d/99-kubernetes-cri.conf <<'EOF'
net.bridge.bridge-nf-call-iptables = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward = 1
EOF

sysctl --system

setenforce 0 || true
sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

dnf install -y dnf-plugins-core curl tar iproute-tc

dnf config-manager --add-repo \
  https://download.docker.com/linux/centos/docker-ce.repo

dnf install -y containerd.io

mkdir -p /etc/containerd
containerd config default > /etc/containerd/config.toml

sed -i \
  's/SystemdCgroup = false/SystemdCgroup = true/' \
  /etc/containerd/config.toml

systemctl enable --now containerd

cat > /etc/yum.repos.d/kubernetes.repo <<'EOF'
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.37/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.37/rpm/repodata/repomd.xml.key
EOF

dnf install -y kubelet kubeadm

systemctl enable --now kubelet

echo "Downloading the worker join script..."

curl --fail --show-error --silent \
  --connect-timeout 10 \
  http://10.30.1.10:8080/join.sh \
  -o /root/kubeadm-join.sh

chmod 700 /root/kubeadm-join.sh

bash /root/kubeadm-join.sh

echo "Worker bootstrap completed."