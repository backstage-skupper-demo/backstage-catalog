#!/bin/bash

curl -LO https://releases.hashicorp.com/terraform/1.6.1/terraform_1.6.1_linux_amd64.zip
unzip terraform_1.6.1_linux_amd64.zip
rm terraform_1.6.1_linux_amd64.zip
mv terraform /home/user/.local/bin

pip3 install --upgrade pip
pip3 install ansible hvac
ansible-galaxy collection install community.hashi_vault
ansible-galaxy collection install skupper.network

curl https://skupper.io/install.sh | sh

mkdir glab
cd glab
curl -LO https://gitlab.com/gitlab-org/cli/-/releases/v1.33.0/downloads/glab_1.33.0_Linux_x86_64.tar.gz
tar -xvzf glab_1.33.0_Linux_x86_64.tar.gz
mv bin/glab /home/user/.local/bin