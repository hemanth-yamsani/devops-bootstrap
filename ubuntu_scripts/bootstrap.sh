#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive

#######################################
# Git identity (idempotent)
#######################################
if ! git config --global user.name >/dev/null; then
  git config --global user.name "Hemanth Yamsani"
  git config --global user.email "hemanth.griet@gmail.com"
fi

#######################################
# Base OS packages
#######################################
echo "▶ Updating apt cache"
sudo apt update -y

echo "▶ Installing base Linux & troubleshooting tools"
sudo apt install -y \
  ca-certificates \
  apt-transport-https \
  software-properties-common \
  curl \
  wget \
  git \
  unzip \
  zip \
  less \
  jq \
  tree \
  gnupg \
  bash-completion \
  make \
  python3 \
  python3-pip \
  net-tools \
  iputils-ping \
  dnsutils \
  lsof \
  traceroute \
  tcpdump \
  nmap \
  httpie

#######################################
# Docker
#######################################
echo "▶ Installing Docker"
if ! command -v docker >/dev/null; then
  curl -fsSL https://get.docker.com | sudo sh
  sudo usermod -aG docker "$USER"
fi

#######################################
# Kubernetes tooling
#######################################
echo "▶ Installing kubectl"
if ! command -v kubectl >/dev/null; then
  curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
  sudo install -m 0755 kubectl /usr/local/bin/kubectl
  rm kubectl
fi

echo "▶ Installing Helm"
if ! command -v helm >/dev/null; then
  curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

#######################################
# Cloud CLI
#######################################
echo "▶ Installing AWS CLI"
if ! command -v aws >/dev/null; then
  curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o awscliv2.zip
  unzip awscliv2.zip
  sudo ./aws/install
  rm -rf aws awscliv2.zip
fi

#######################################
# Infrastructure as Code
#######################################
echo "▶ Installing Terraform"
if ! command -v terraform >/dev/null; then
  curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" \
    | sudo tee /etc/apt/sources.list.d/hashicorp.list
  sudo apt update -y
  sudo apt install -y terraform
fi

echo "▶ Installing Ansible"
sudo apt install -y ansible

#######################################
# AWS Pager (INTENTIONALLY DISABLED)
#######################################
# We have `less` installed, pager output is readable.
# Uncomment ONLY if you hate pagers.
#
# if ! grep -q "AWS_PAGER" ~/.bashrc; then
#   echo 'export AWS_PAGER=""' >> ~/.bashrc
# fi

#######################################
echo "✅ DevOps bootstrap complete"
echo "⚠️  Logout/login required for Docker group to take effect"
