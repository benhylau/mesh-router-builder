#!/usr/bin/env bash

# Install standard tools
apt install -y \
  apache2 \
  apt-transport-https \
  build-essential \
  ca-certificates \
  curl \
  git \
  gnupg2 \
  qemu-user-static \
  software-properties-common \
  swapspace \
  vim

# Install docker-ce
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
apt-get update
apt-get install -y docker-ce

# Install golang
mkdir /tmp/golang
wget --progress=bar:force https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz -P /tmp/golang
tar -C /usr/local -xzf /tmp/golang/go1.9.2.linux-amd64.tar.gz
{
  echo ''
  echo '# Add golang path'
  echo 'export PATH=$PATH:/usr/local/go/bin'
} >> /etc/profile

# Install nodejs
curl -sL https://deb.nodesource.com/setup_7.x | sudo -E bash -
apt-get install -y nodejs

# Copy build scripts from Synced Folder to Vagrant machine user home
cp -r /vagrant/src/* /home/vagrant/
chown -R vagrant:vagrant /home/vagrant/*

# Copy github release publishing configurations
if [ -f /vagrant/.github_publish ]; then
  . /vagrant/.github_publish
  {
    echo ''
    echo '# GitHub Release publishing configurations'
    echo "export GITHUB_USERNAME=$GITHUB_USERNAME"
    echo "export GITHUB_REPOSITORY=$GITHUB_REPOSITORY"
    echo "export GITHUB_TOKEN=$GITHUB_TOKEN"
    echo "export GITHUB_RELEASE_VERSION=$GITHUB_RELEASE_VERSION"
  } >> /etc/profile
fi