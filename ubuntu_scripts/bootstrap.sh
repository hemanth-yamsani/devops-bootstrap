#!/usr/bin/env bash
set -e


# Set git identity only if not already set
if ! git config --global user.name >/dev/null; then
  git config --global user.name "Hemanth Yamsani"
  git config --global user.email "hemanth.griet@gmail.com"
fi


echo "▶ Updating apt cache"
sudo apt update -y

echo "▶ Installing base DevOps packages"
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
  openssh-client \
  gnupg \
  bash-completion \
  make \
  python3 \
  python3-pip \
  net-tools \
  iputils-ping \
  dnsutils \
  lsof

echo "▶ Disabling AWS CLI pager"
if ! grep -q "AWS_PAGER" ~/.bashrc; then
  echo 'export AWS_PAGER=""' >> ~/.bashrc
fi

echo "✅ Base bootstrap complete"
