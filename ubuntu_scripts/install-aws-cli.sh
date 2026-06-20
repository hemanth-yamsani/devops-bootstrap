#!/usr/bin/env bash
set -e

if command -v aws >/dev/null 2>&1; then
  echo "✅ AWS CLI already installed"
  aws --version
  exit 0
fi

echo "▶ Installing AWS CLI v2"
curl -sSL https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o awscliv2.zip
unzip -q awscliv2.zip
sudo ./aws/install

echo "✅ AWS CLI installed"
aws --version
